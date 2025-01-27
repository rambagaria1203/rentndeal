import 'package:get_storage/get_storage.dart';
import 'package:rentndeal/backend_services/repositories/authentication_repository.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/helpers/general_functions/network_manager.dart';
import 'package:rentndeal/helpers/popups/full_screen_loader.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';

class LoginController extends GetxController {

  // Variable
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? "";
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? "";
    super.onInit();
  }

  // --- Email and Password Signin
  Future<void> emailAndPasswordSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog('Logging you in...', CImages.datasave);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form validator
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using Email & Password Authenticate
      //final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());


      // Remove Loader
      FullScreenLoader.stopLoading();

      // Redirect 
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Google SignIn
  Future<void> googleSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog('Logging you in...', CImages.datasave);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      //Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // Save User Record
      await UserController.instance.saveUserData(userCredentials);

      //Remove Loader
      FullScreenLoader.stopLoading();

      // Redirsct User
      AuthenticationRepository.instance.screenRedirect();

    }catch (e) {
      //Remove Loader
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }

  }


}