import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/screen/login/login_form.dart';

class LoginS extends StatelessWidget {
  const LoginS({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: CSizes.appBarHeight, left: CSizes.defaultSpace, bottom: CSizes.defaultSpace, right: CSizes.defaultSpace),
          child: Column(
            children: [

              // Logo, Title & Sub-Title
              Column(
                children: [
                  Image(height: 150, image: AssetImage(dark ? CImages.icAppLogoLight : CImages.icAppLogoLight),),
                  Text(CString.loginTitle, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: CSizes.sm),
                  Text(CString.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium),
                ]
              ),

              // Form
              const LoginForm(),
              HFormDivider(dividerText: CString.orSigninWith.capitalize!),
              const SizedBox(height: CSizes.spaceBtwSections),

              /// Footer
              const SocialWidget(),

            ],
          ),
          ),
      ),
    );
  }
}

