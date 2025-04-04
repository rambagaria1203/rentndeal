import 'dart:io';

import 'package:get/get.dart';
import 'package:rentndeal/features/chat/FirebaseHelper.dart';
import 'package:rentndeal/features/chat/models/chat_model.dart';
import 'package:rentndeal/helpers/popups/full_screen_loader.dart';
import 'package:rentndeal/backend_services/models/user_model.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';
import 'package:rentndeal/features/chat/interfaces/i_chat_repository.dart';

class NewChatController extends GetxController {
  static NewChatController get instance => Get.find();

  final IChatRepository repository;
  //final userController = UserController.instance;

  final chatList = <ChatModel>[].obs;
  final messageList = <MessageModel>[].obs;

  NewChatController({required this.repository});

//-------------------------------------------------------------------LOAD CHATS------------------------------------------------------------------------------------------//
  Stream<List<ChatModel>> loadChats(String userId) {
    try {
      return repository.getUserChats(userId);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error loading chats', message: e.toString());
      return const Stream.empty();
    }
  }

//--------------------------------------------------------------LOAD MESSAGES-------------------------------------------------------------------------------------------//
  Future<void> loadMessages(String chatId) async {
    try {
      repository.getMessages(chatId).listen((messages) {
        messageList.assignAll(messages);
      });
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error loading messages', message: e.toString());
    }
  }

//-----------------------------------------------------------------SEND MESSAGE-------------------------------------------------------------------------------------------//
  Future<void> sendMessage(String chatId, MessageModel message) async {
    try {
      await repository.sendMessage(chatId, message);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Send failed', message: e.toString());
    }
  }

//------------------------------------------------------------CREATE OR GET CHAT ID---------------------------------------------------------------------------------------//
  Future<String?> getOrCreateChatId({required String productId, required String userId, required String vendorId}) async {
    try {
      FullScreenLoader.openLoadingDialog('Creating chat...', 'assets/icons/chat.png');
      final chatId = await repository.createOrGetChatId(
        productId: productId,
        userId: userId,
        vendorId: vendorId,
      );
      FullScreenLoader.stopLoading();
      return chatId;
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Failed to start chat', message: e.toString());
      return null;
    }
  }

//-------------------------------------------------------------------------GET USER MODEL----------------------------------------------------------------------------------------//
  Future<UserModel?> getUserModel({required String userId}) async {
    try {
      return await FirebaseHelper.getUserModelById(userId);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Failed to load user', message: e.toString());
      return null;
    }
  }


//------------------------------------------------------------------------UPDATE MESSAGE STATUS---------------------------------------------------------------------------//
  Future<void> updateMessageStatus({
    required String chatId,
    required String messageId,
    required String statusType,
  }) async {
    try {
      await repository.updateMessageStatus(chatId: chatId,messageId: messageId,statusType: statusType,);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Failed to update status', message: e.toString());
    }
  }

//------------------------------------------------------------------UPLOAD CHAT IMAGES------------------------------------------------------------------------------------------------//
  Future<String> uploadChatImage(File imageFile, String chatId) async {
    try {
      return await repository.uploadChatImage(imageFile, 'chatImages/$chatId');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Failed to update status', message: e.toString());
      return "";
    }
  }
//-----------------------------------------------------------------------DELETE OLD MESSAGES------------------------------------------------------------------------------//
  Future<void> deleteOldMessages(String chatId) async {
    try {
      await repository.deleteOldMessages(chatId);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Cleanup failed', message: e.toString());
    }
  }


//----------------------------------------------------------------DELETE INACTIVE CHATS---------------------------------------------------------------------------------//
  Future<void> deleteInactiveChats() async {
    try {
      await repository.deleteInactiveChats();
    } catch (e) {
      Loaders.errorSnackBar(title: 'Cleanup failed', message: e.toString());
    }
  }


//----------------------------------------------------------------MARK UNREAD MESSAGE AS READ---------------------------------------------------------------------------------//
  Future<void> markUnreadMessagesAsRead(String chatId, String currentUserId) async {
    try {
      await repository.markMessagesAsRead(chatId, currentUserId);
    } catch (e) {
            print('**************************************************************************************************************************************************************************');

      print('error: $e.string()');
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

//-----------------------------------------------------------------------END--------------------------------------------------------------------------------------------------//
}
