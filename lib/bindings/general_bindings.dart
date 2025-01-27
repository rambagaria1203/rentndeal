
import 'package:rentndeal/helpers/general_functions/network_manager.dart';

import '../constants/consts.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}