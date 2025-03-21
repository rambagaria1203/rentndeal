import 'dart:async';

import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // Send email whenever verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // Send email verification Link
  sendEmailVerification() async {
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(title: 'Email Sent', message: 'Please check you inbox and verify your email.');

    }catch(e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
  // TImer to automatically redirect on email verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessEmailVerification(
          image: CImages.successscreen,
          title: CString.yourAccountCreatedTitle,
          subTitle: CString.yourAccountCreatedSubTitle,
          onPressed: ()=> AuthenticationRepository.instance.screenRedirect(),
        ));
      }
    }
    );
  }

  // Manually check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessEmailVerification(
        image: CImages.successscreen,
        title: CString.yourAccountCreatedTitle,
        subTitle: CString.yourAccountCreatedSubTitle,
        onPressed: ()=> AuthenticationRepository.instance.screenRedirect(),
      ));
    }
  }
}