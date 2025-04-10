import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/chat/controller/new_chat_controller.dart';
import 'package:rentndeal/features/chat/interfaces/i_chat_repository.dart';
import 'package:rentndeal/features/chat/repositories/new_chat_repository.dart';
import 'package:rentndeal/helpers/general_functions/network_manager.dart';

import '../constants/consts.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(UserRepository());
    Get.put(UserController());
    Get.put<ILocationRepository>(LocationRepository());
    Get.put(LocationController(repository: Get.find()));
    Get.put<IChatRepository>(NewChatRepository());
    Get.put(NewChatController(repository: Get.find()));
  }
}