import 'package:rentndeal/constants/consts.dart';


class HDeviceUtils {
  HDeviceUtils._();

  static double getStatusBarHeight() {
    return MediaQuery.of(Get.context!).padding.top;
  }


  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }


  static double getAppBarHeight() {
    return kToolbarHeight;
  }


  static double getKeyboardHeight() {
    final viewInsert = MediaQuery.of(Get.context!).viewInsets;
    return viewInsert.bottom;
  }


  static Future<bool> isKeyboardVisible() async {
    final viewInsert = MediaQuery.of(Get.context!).viewInsets;
    return viewInsert.bottom > 0;
  }


  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

}