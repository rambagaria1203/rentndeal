import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/helpers/general_functions/validator.dart';

class ReAuthUser extends StatelessWidget {
  const ReAuthUser({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: Validator.validateEmail,
                  decoration: const InputDecoration(prefix: Icon(Iconsax.direct_right), labelText: CString.email),
                ),
                const SizedBox(height: CSizes.spaceBtwInputFields),

                // password
                Obx(
                  () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.verifyPassword,
                    validator: (value) => Validator.validateEmptyText('password', value),
                    decoration: InputDecoration(
                      prefix: const Icon(Iconsax.password_check), 
                      labelText: CString.password,
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value, 
                        icon: const Icon(Iconsax.eye_slash),
                      )
                    ),
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwSections),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPasswordUser(), child: const Text('Verify')),
                )
              ]
            )
          ),
        )
      )
    );
  }
}