import 'package:cloud_firestore/cloud_firestore.dart';

//-----------------------------------------------------------------------CHAT MODEL------------------------------------------------------------------------------------------------//
class ChatModel {
  final String chatId;
  final String productId;
  final List<String> participants;
  final String lastMessage;
  final DateTime timestamp;
  final String lastSenderId;
  final bool lastMessageIsRead;


  ChatModel({
    required this.chatId,
    required this.productId,
    required this.participants,
    required this.lastMessage,
    required this.timestamp,
    required this.lastSenderId,
    required this.lastMessageIsRead,
  });

  factory ChatModel.fromSnapshot(String id, Map<String, dynamic> data) {
    return ChatModel(
      chatId: id,
      productId: data['productId'],
      participants: List<String>.from(data['participants']),
      lastMessage: data['lastMessage'] ?? "",
      lastSenderId: data['lastSenderId'] ?? '',
      lastMessageIsRead: data['lastMessageIsRead'] ?? true,
      timestamp: data['timestamp'] is Timestamp ? (data['timestamp'] as Timestamp).toDate() : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'participants': participants,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
      'lastSenderId': lastSenderId,
      'lastMessageIsRead': lastMessageIsRead,
    };
  }
}


//-----------------------------------------------------------------------MESSAGE MODEL------------------------------------------------------------------------------------------------//
class MessageModel {
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isRead;
  final String? imageUrl;
  final String? videoUrl;
  final String? videoThumbnailUrl;
  final String type;

  MessageModel({
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isRead,
    this.imageUrl,
    this.videoUrl,
    this.videoThumbnailUrl,
    this.type = 'text',
  });

  factory MessageModel.fromSnapshot(Map<String, dynamic> data) {
    return MessageModel(
      senderId: data['senderId'],
      text: data['text'] ?? "",
      timestamp: data['timestamp'] is Timestamp ? (data['timestamp'] as Timestamp).toDate() : DateTime.now(),
      isRead: data['isRead'] ?? false,
      imageUrl: data['imageUrl'],
      videoUrl: data['videoUrl'],
      videoThumbnailUrl: data['videoThumbnailUrl'],
      type: data['type'] ?? 'text',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
      'isRead': isRead,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'videoThumbnailUrl': videoThumbnailUrl,
      'type': type,
    };
  }
}
