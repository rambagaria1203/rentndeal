import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final String productId;
  final List<String> participants;
  final String lastMessage;
  final DateTime timestamp;

  ChatModel({
    required this.chatId,
    required this.productId,
    required this.participants,
    required this.lastMessage,
    required this.timestamp,
  });

  factory ChatModel.fromMap(String id, Map<String, dynamic> data) {
    return ChatModel(
      chatId: id,
      productId: data['productId'],
      participants: List<String>.from(data['participants']),
      lastMessage: data['lastMessage'] ?? "",
      timestamp: data['timestamp'] is Timestamp ? (data['timestamp'] as Timestamp).toDate() : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'participants': participants,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
    };
  }
}

class MessageModel {
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isRead;

  MessageModel({
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isRead,
  });

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    return MessageModel(
      senderId: data['senderId'],
      text: data['text'] ?? "",
      timestamp: data['timestamp'] is Timestamp ? (data['timestamp'] as Timestamp).toDate() : DateTime.now(),
      isRead: data['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
      'isRead': isRead,
    };
  }
}
