import 'package:rentndeal/constants/consts.dart';

class HomeeController extends GetxController {
  static HomeeController get instance => Get.find();

  final carousalCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }
}