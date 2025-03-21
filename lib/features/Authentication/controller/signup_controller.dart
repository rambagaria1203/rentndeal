import 'package:rentndeal/backend_services/models/user_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/helpers/general_functions/network_manager.dart';
import 'package:rentndeal/helpers/popups/full_screen_loader.dart';

import 'package:rentndeal/features/common_function/loaders/loader.dart';


class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variable
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Form key for form validation

  // Signup
  void signup() async {
    try {
      //Start Loading
      FullScreenLoader.openLoadingDialog('We are processing your information...', CImages.datasave);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        // Remove Loader
        FullScreenLoader.stopLoading();
        Loaders.errorSnackBar(title: 'No Internet', message: 'Please check your internet connection and try again.');
        return;
      }

      // Privacy Policy Check
      if(!privacyPolicy.value) {
        FullScreenLoader.stopLoading();
        Loaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'Please accept the privacy policy to proceed.',
        );
        return;
      }

      // Form Validator
      if (!signupFormKey.currentState!.validate()) {
        // Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }
      

      

      // Register user in the firebase Authentication & save user data in the firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save Authentication user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid, 
        firstName: firstName.text.trim(), 
        lastName: lastName.text.trim(), 
        email: email.text.trim(), 
        phoneNumber: phoneNumber.text.trim(),
        location: '',
        locationGeopoint: null,
        profilePicture: ''
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserData(newUser);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');

      // Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));


    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
    
      // Show some Generic Error to the user
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}