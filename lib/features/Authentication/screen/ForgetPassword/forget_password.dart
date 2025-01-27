import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/helpers/general_functions/validator.dart';
import 'package:rentndeal/features/Authentication/controller/forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Headings
            Text(CString.forgotPassword, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: CSizes.spaceBtwItems),
            Text(CString.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: CSizes.spaceBtwItems * 2),

            // Text Field
            Form(
              key: controller.forgetPasswordFromKey,
              child: TextFormField(
                controller: controller.email,
                validator: Validator.validateEmail,
                decoration: const InputDecoration(labelText: CString.email, prefixIcon: Icon(Iconsax.direct_right)),),
            ),
              const SizedBox(height: CSizes.spaceBtwItems),

            SizedBox(width:double.infinity, child: ElevatedButton(onPressed: ()=> controller.sendPasswordResetEmail(controller.email.text), child: const Text(CString.submit)))

          ],
        )
      )
    );
  }
}