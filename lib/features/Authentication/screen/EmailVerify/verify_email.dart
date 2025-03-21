import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
  final controller = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed:()=> Get.off(()=> AuthenticationRepository.instance.logout()), icon: const Icon(Icons.close))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              // Image
              Image(image: const AssetImage(CImages.emailverify), width: HHelperFunctions.screenWidth() * 0.6,),
              const SizedBox(height: CSizes.spaceBtwSections),

              // Title
              Text(CString.confirmEmail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwItems),
              Text(email ?? '', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwItems),
              Text(CString.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
              const SizedBox(height: CSizes.spaceBtwSections),

              //Button
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> controller.checkEmailVerificationStatus(), 
                child: const Text(CString.eContinue)),
              ),

              const SizedBox(height: CSizes.spaceBtwItems),

              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: ()=> controller.sendEmailVerification(), child: const Text(CString.resendEmail)),),


            ],

          ))

      ),
    );
  }
}