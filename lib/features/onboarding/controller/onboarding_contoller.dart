import 'package:get_storage/get_storage.dart';
import 'package:rentndeal/constants/consts.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();


  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update Current Index when Page Scroll
  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }


  // Jump to the specific dot selected page
  void dotnavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }


  //Update current index & jump to next page
  void nextPage() {
    if(currentPageIndex.value == 2){
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Get.to(()=> const LoginS());
    }
    else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }

  }


  // Update Current Index & jump to last page
  void skipPage() {
    Get.to(()=> const LoginS());

  }
}