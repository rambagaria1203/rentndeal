import 'package:rentndeal/constants/consts.dart';
import '../../features/common_function/loaders/animation_loader.dart';

class FullScreenLoader {

  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: HHelperFunctions.isDarkMode(Get.context!) ? CColors.dark : CColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(child: AnimationLoaderWidget(text: text, animation: animation)),
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}