import 'package:rentndeal/features/chat/models/chat_model.dart';

abstract class IChatRepository {
  Stream<List<ChatModel>> getUserChats(String userId);
  Stream<List<MessageModel>> getMessages(String chatId);
  Future<void> sendMessage(String chatId, MessageModel message);
  Future<String> createOrGetChatId({required String productId, required String buyerId, required String vendorId});
}