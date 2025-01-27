import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/screen/signup/signup_form.dart';

class SignupS extends StatelessWidget {
  const SignupS({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              ///
              Text(CString.letCreateYourAccount, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: CSizes.spaceBtwSections),
              // Form
              const SignupForm(),
              const SizedBox(height: CSizes.spaceBtwSections,),
              const HFormDivider(dividerText: CString.orSignupWith),
              const SizedBox(height: CSizes.spaceBtwItems),

              // Social 
              const SocialWidget(),
            ],
          ),
        ),

    )
    );
  }
}

