import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/helpers/general_functions/validator.dart';
//import 'package:rentndeal/new_rentndeal_app/Authentication/controller/forget_password_controller.dart';
import 'package:rentndeal/features/Authentication/controller/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.email,
              validator: (value) => Validator.validateEmail(value),
              decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: CString.email)),
            const SizedBox(height: CSizes.spaceBtwInputFields),
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => Validator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(labelText: CString.password, 
                prefixIcon: const Icon(Iconsax.direct), 
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)
                )
              ),
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwInputFields / 2,),
          
            // Remeber Me * Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember me
                Row(
                  children: [
                    Obx(() => Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                    const Text(CString.rememberMe),
                  ] 
                ),
                // Forget Password
                TextButton(onPressed: () => Get.to(()=> const ForgetPasswordScreen()), child: const Text(CString.forgotPassword)),
              ],
            ),
            const SizedBox(height: CSizes.spaceBtwSections),
        
            // Sign In Button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.emailAndPasswordSignIn(), child: const Text(CString.signIn))),
            const SizedBox(height: CSizes.spaceBtwItems),
    
            // Signin Button
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Get.to(() => const SignupS()), child: const Text(CString.createAccount))),
          ]
        ),
      ),
    );
  }
}