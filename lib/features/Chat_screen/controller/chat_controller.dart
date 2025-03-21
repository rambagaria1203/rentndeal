import 'package:rentndeal/backend_services/models/chatroom_model.dart';
import 'package:rentndeal/backend_services/models/user_model.dart';
import 'package:rentndeal/backend_services/repositories/chat_repository.dart';
import 'package:rentndeal/constants/consts.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();

  final _chatRepository = Get.put(ChatRepository());
  final _userRepository = UserRepository.instance;

// Get or Create Chat Room
  Future<ChatRoomModel> getOrCreateChatRoom({required String currentUserId, required String targetUserId}) async {
    ChatRoomModel? existingChatRoom = await _chatRepository.fetchChatRoom(currentUserId: currentUserId, targetUserId: targetUserId);
    if (existingChatRoom != null) {
      return existingChatRoom;
    }
    return await _chatRepository.createChatRoom(currentUserId: currentUserId, targetUserId: targetUserId);
  }

// Get UserModel
  Future<UserModel> getUserModel({required String userId}) async {
    return await _userRepository.fetchUserDetailsByUserId(userId: userId);
  }


}