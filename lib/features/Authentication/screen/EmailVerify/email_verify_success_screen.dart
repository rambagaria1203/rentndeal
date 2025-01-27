import 'package:rentndeal/constants/consts.dart';

class SuccessEmailVerification extends StatelessWidget {
  const SuccessEmailVerification({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: CSizes.appBarHeight, left: CSizes.defaultSpace, right: CSizes.defaultSpace, bottom: CSizes.defaultSpace) * 2,
            child: Column(
              children: [

                // Image
                Image(image: AssetImage(image), width: HHelperFunctions.screenWidth() * 0.6),
                const SizedBox(height: CSizes.spaceBtwSections),

                // Title
                Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
                const SizedBox(height: CSizes.spaceBtwItems),
                Text(subTitle, style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
                const SizedBox(height: CSizes.spaceBtwSections),

                //Button
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onPressed, child: const Text(CString.eContinue)),),

              ],
          ),
    )
      )
    );
  }
}