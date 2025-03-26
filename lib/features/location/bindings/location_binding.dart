import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ILocationRepository>(() => LocationRepository());
    Get.lazyPut(() => UserController());
    Get.lazyPut(()=> LocationController(repository: Get.find<ILocationRepository>()));
  }
}