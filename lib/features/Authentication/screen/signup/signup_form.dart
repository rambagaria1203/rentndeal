import 'package:get/get.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/helpers/general_functions/validator.dart';
import 'package:rentndeal/features/Authentication/controller/signup_controller.dart';
//import 'package:rentndeal/new_rentndeal_app/Authentication/screen/EmailVerify/verify_email.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                validator: (value) => Validator.validateEmptyText('First name', value),
                expands: false,
                decoration:const InputDecoration(labelText: CString.firstName, prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(width: CSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                controller: controller.lastName,
                validator: (value) => Validator.validateEmptyText('Last name', value),
                expands: false,
                decoration:const InputDecoration(labelText: CString.lastName, prefixIcon: Icon(Iconsax.user)),
              ),
            ),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwInputFields),
        // Email
        TextFormField(
          controller: controller.email,
          validator: (value) => Validator.validateEmail(value),
          decoration:const InputDecoration(labelText: CString.email, prefixIcon: Icon(Iconsax.direct)),
        ),
        const SizedBox(height: CSizes.spaceBtwInputFields),
    
        //Phone Number
        TextFormField(
          controller: controller.phoneNumber,
          validator: (value) => Validator.validatePhoneNumber(value),
          decoration:const InputDecoration(labelText: CString.phoneNumber, prefixIcon: Icon(Iconsax.direct)),
        ),
        const SizedBox(height: CSizes.spaceBtwInputFields),
    
    
        // Password
        Obx(
          () => TextFormField(
            controller: controller.password,
            validator: (value) => Validator.validatePassword(value),
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
        const SizedBox(height: CSizes.spaceBtwInputFields),
        
    
        // Terms & Conditions
        Row(
          children: [
            SizedBox(width: 24, height:24, child: Obx(() => Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value))),
            const SizedBox(width: CSizes.spaceBtwItems),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(text: '${CString.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
                
                    TextSpan(text: CString.privacyPolicy, style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? CColors.white: CColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark? CColors.white: CColors.primary),),
                    
                    TextSpan(text: ' & ', style: Theme.of(context).textTheme.bodySmall),
                
                    TextSpan(text: CString.termsAndConditions, style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? CColors.white: CColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark? CColors.white: CColors.primary),)
                  
                  ]),
                ),
              ),
            ),
          ]
        ),
        const SizedBox(height: CSizes.spaceBtwSections),
    
        SizedBox(
          width: double.infinity, 
          child: ElevatedButton(
            onPressed: () => controller.signup(), 
            child: const Text(CString.createAccount)
          ),
        )
    
    
      ],
    )
    );
  }
}