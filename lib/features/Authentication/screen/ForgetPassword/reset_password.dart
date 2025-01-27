import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/forget_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=> Get.back(), icon: const Icon(Icons.close),)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              Image(image: const AssetImage(CImages.resetPassword), width: HHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: CSizes.spaceBtwSections),
              // Email
              Text(email, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwItems),

              Text(CString.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwItems),
              Text(CString.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwSections),

                //Button
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.offAll(() => const LoginS()), child: const Text(CString.done)),),
              const SizedBox(height: CSizes.spaceBtwItems),
              SizedBox(width: double.infinity, child: TextButton(onPressed: () => ForgetPasswordController.instance.sendPasswordResetEmail(email) , child: const Text(CString.resendEmail)),),
            ]
        ),
      ),
    )
    );
  }
}