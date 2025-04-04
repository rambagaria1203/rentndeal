import 'dart:io';

import 'package:rentndeal/features/chat/models/chat_model.dart';

abstract class IChatRepository {
  Future<void> deleteInactiveChats();
  Future<void> deleteOldMessages(String chatId);
  Stream<List<ChatModel>> getUserChats(String userId);
  Stream<List<MessageModel>> getMessages(String chatId);
  Future<String> uploadChatImage(File imageFile, String chatId);
  Future<void> sendMessage(String chatId, MessageModel message);
  Future<void> markMessagesAsRead(String chatId, String currentUserId);
  Future<void> updateMessageStatus({required String chatId, required String messageId, required String statusType});
  Future<String> createOrGetChatId({required String productId, required String userId, required String vendorId});
}