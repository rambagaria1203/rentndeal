import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentndeal/features/chat/interfaces/i_chat_repository.dart';
import 'package:rentndeal/features/chat/models/chat_model.dart';
import 'package:uuid/uuid.dart';

class ChatRepository implements IChatRepository {
  final Uuid _uuid = const Uuid();
  final _db = FirebaseFirestore.instance;


//-----------------------------------------------------------------------GET USER CHATS------------------------------------------------------------------------------------------------//
  @override
  Stream<List<ChatModel>> getUserChats(String userId) {
    try {
      return _db.collection('chats').where('participants', arrayContains: userId).orderBy('timestamp', descending: true)
          .snapshots().map((snapshot) => snapshot.docs.map((doc) => ChatModel.fromMap(doc.id, doc.data())).toList());
    } catch (e) {
      throw Exception('Failed to stream user chats: $e');
    }
  }


//-------------------------------------------------------------GET USER MESSAGES FOR A CHAT------------------------------------------------------------------------------------------------//
  @override
  Stream<List<MessageModel>> getMessages(String  chatId) {
    try {
      return _db.collection('chats').doc(chatId).collection('messages').orderBy('timestamp').snapshots().map((snapshot) => snapshot.docs.map((doc) => MessageModel.fromMap(doc.data())).toList());
    } catch (e) {
      throw Exception('Failed to stream messages for chat: $e');
    }
  }

//------------------------------------------------------------------SEND MESSAGE------------------------------------------------------------------------------------------------//
  @override
  Future<void> sendMessage(String chatId, MessageModel message) async {
    try {
      await _db.collection('chats').doc(chatId).collection('messages').add(message.toMap());
      await _db.collection('chats').doc(chatId).update({
        'lastMessage': message.text,
        'timestamp': message.timestamp,
      });
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

//------------------------------------------------------------------CREATE OR GET CHAT ID------------------------------------------------------------------------------------------------//
  @override
  Future<String> createOrGetChatId({required String productId, required String buyerId, required String vendorId}) async {
    try {
      List<String> participants = [buyerId, vendorId]..sort();
      final query = await _db.collection('chats').where('productId', isEqualTo: productId).where('participants', isEqualTo: participants).limit(1).get();
      if (query.docs.isNotEmpty) {
        return query.docs.first.id;
      } else {
        final chatId = _uuid.v4();
        await _db.collection('chats').doc(chatId).set({
          'productId': productId,
          'participants': participants,
          'lastMessage': '',
          'timestamp': FieldValue.serverTimestamp(),
        });
        return chatId;
      }
    } catch (e) {
      throw Exception('Failed to create or get chat id: $e');
    }
  }


}