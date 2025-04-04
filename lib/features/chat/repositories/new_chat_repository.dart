import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rentndeal/features/chat/interfaces/i_chat_repository.dart';
import 'package:rentndeal/features/chat/models/chat_model.dart';
import 'package:rentndeal/helpers/storage/storage_service.dart';


class NewChatRepository implements IChatRepository {
  final Uuid _uuid = const Uuid();
  final _db = FirebaseFirestore.instance;
  final _storageService = StorageService();
  final _storage = FirebaseStorage.instance;


//-----------------------------------------------------------------------GET USER CHATS------------------------------------------------------------------------------------------------//
  @override
  Stream<List<ChatModel>> getUserChats(String userId) {
    try {
      return _db.collection('chats').where('participants', arrayContains: userId).orderBy('timestamp', descending: true)
          .snapshots().map((snapshot) => snapshot.docs.map((doc) => ChatModel.fromSnapshot(doc.id, doc.data())).toList());
    } catch (e) {
      throw Exception('Failed to stream user chats: $e');
    }
  }


//-------------------------------------------------------------GET USER MESSAGES FOR A CHAT------------------------------------------------------------------------------------------------//
  @override
  Stream<List<MessageModel>> getMessages(String  chatId) {
    try {
      return _db.collection('chats').doc(chatId).collection('messages').orderBy('timestamp').snapshots().map((snapshot) => snapshot.docs.map((doc) => MessageModel.fromSnapshot(doc.data())).toList());
    } catch (e) {
      throw Exception('Failed to stream messages for chat: $e');
    }
  }

//------------------------------------------------------------------SEND MESSAGE------------------------------------------------------------------------------------------------//
  @override
  Future<void> sendMessage(String chatId, MessageModel message) async {
    try {
      //await _db.collection('chats').doc(chatId).collection('messages').add(message.toMap());
      String preview;
      switch (message.type) {
        case 'image': preview = '[Image]'; break;
        case 'video': preview = '[Video]'; break;
        case 'emoji': preview = message.text; break;
        default: preview = message.text;
      }
      final batch = _db.batch();
      final chatRef = _db.collection('chats').doc(chatId);
      final messageRef = chatRef.collection('messages').doc();
      batch.set(messageRef,message.toMap());
      batch.update(chatRef, {
        'lastMessage': preview,
        'timestamp': message.timestamp,
        'lastSenderId': message.senderId,
        'lastMessageIsRead': false,
      });
      await batch.commit();
      //await _db.collection('chats').doc(chatId).update({'lastMessage': preview, 'timestamp': message.timestamp,});
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }


//------------------------------------------------------------------UPLOAD CHAT IMAGES------------------------------------------------------------------------------------------------//
  @override
  Future<String> uploadChatImage(File imageFile, String chatId) async {
    try {
      return await _storageService.uploadFile(imageFile, 'chatImages/$chatId');
    } catch (e) {
      throw Exception('Failed to upload chat image: $e');
    }
  }


//------------------------------------------------------------------CREATE OR GET CHAT ID------------------------------------------------------------------------------------------------//
  @override
  Future<String> createOrGetChatId({required String productId, required String userId, required String vendorId}) async {
    try {
      List<String> participants = [userId, vendorId]..sort();
      final query = await _db.collection('chats').where('participants', isEqualTo: participants).limit(1).get();
      if (query.docs.isNotEmpty) {
        return query.docs.first.id;
      } else {
        final chatId = _uuid.v4();
        await _db.collection('chats').doc(chatId).set({
          'productId': productId,
          'participants': participants,
          'lastMessage': '',
          'timestamp': FieldValue.serverTimestamp(),
          'lastSenderId': '',
          'lastMessageIsRead': false,
        });
        return chatId;
      }
    } catch (e) {
      throw Exception('Failed to create or get chat id: $e');
    }
  }


//------------------------------------------------------------------UPDATE MESSAGE STATUS------------------------------------------------------------------------------------------------//
  @override
  Future<void> updateMessageStatus({required String chatId, required String messageId, required String statusType}) async {
    try {
      await _db.collection('chats').doc(chatId).collection('messages').doc(messageId).update({statusType: true});
    } catch (e) {
      throw Exception('Failed to update message status: $e');
    }
  }


//------------------------------------------------------------------DELETE MESSAGES OLDER THAN 90 DAYS---------------------------------------------------------------------//
  @override
  Future<void> deleteOldMessages(String chatId) async {
    try {
      final ninetyDaysAgo = DateTime.now().subtract(const Duration(days: 90));
      final oldMessages = await _db.collection('chats').doc(chatId).collection('messages').where('timestamp', isLessThan: Timestamp.fromDate(ninetyDaysAgo)).get();
      for (var doc in oldMessages.docs) {
        final data = doc.data();
        final message = MessageModel.fromSnapshot(data);
        if (message.type == 'image' && message.imageUrl != null) {
          try {
            final ref = _storage.refFromURL(message.imageUrl!);
            await ref.delete();
          } catch (_) {}
        }
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete old messages: $e');
    }
  }


//------------------------------------------------------------------DELETE INACTIVE CHATS (NO ACTIVITY IN 90 DAYS)--------------------------------------------------------//
  @override
  Future<void> deleteInactiveChats() async {
    try {
      final ninetyDaysAgo = DateTime.now().subtract(const Duration(days: 90));
      final oldChats = await _db.collection('chats').where('timestamp', isLessThan: Timestamp.fromDate(ninetyDaysAgo)).get();
      for (var chat in oldChats.docs) {
        final messages = await chat.reference.collection('messages').get();
        for (var msg in messages.docs) {
          final message = MessageModel.fromSnapshot(msg.data());
          if (message.type == 'image' && message.imageUrl != null) {
            try {
              final ref = _storage.refFromURL(message.imageUrl!);
              await ref.delete();
            } catch (_) {}
          }
          await msg.reference.delete();
        }
        await chat.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete inactive chats: $e');
    }
  }


//------------------------------------------------------------------MARK MESSAGE AS READ--------------------------------------------------------//
  @override
  Future<void> markMessagesAsRead(String chatId, String currentUserId) async {
  try {
    final snapshot = await _db.collection('chats').doc(chatId).collection('messages').where('isRead', isEqualTo: false).get();
    final batch = _db.batch();
    bool shouldMarkChatAsRead = false;
    for (final doc in snapshot.docs) {
      final data = doc.data();
      if (data['senderId'] != currentUserId){
        batch.update(doc.reference, {'isRead': true});
        shouldMarkChatAsRead = true;
      }
    }
    if (shouldMarkChatAsRead) {
      batch.update(_db.collection('chats').doc(chatId), {'lastMessageIsRead': true});
    }
    await batch.commit();
  } catch (e) {
    throw Exception('Failed to mark messages as read: $e');
  }
}

//------------------------------------------------------------------END-----------------------------------------------------------------------//
}