import 'package:rentndeal/constants/consts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunctions.isDarkMode(context);
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          // Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(image: CImages.onboardingImage1, title:CString.onboardingTitle1, subtitle: CString.onboardingSubTitle1),
              OnBoardingPage(image: CImages.onboardingImage2, title:CString.onboardingTitle2, subtitle: CString.onboardingSubTitle2),
              OnBoardingPage(image: CImages.onboardingImage3, title:CString.onboardingTitle3, subtitle: CString.onboardingSubTitle3),
            ],
          ),


          // Skip Button
          Positioned(top: HDeviceUtils.getAppBarHeight(), right: CSizes.defaultSpace, child: TextButton(onPressed: () => OnBoardingController.instance.skipPage(), child: const Text('Skip'))),


          // Bot Naviagtion SmoothPpageIndicator
          Positioned(
            bottom: HDeviceUtils.getBottomNavigationBarHeight() + 25, 
            left: CSizes.defaultSpace,
            child: SmoothPageIndicator(controller: controller.pageController, count: 3,
              onDotClicked: controller.dotnavigationClick,
              effect: ExpandingDotsEffect(activeDotColor: dark ? CColors.light :CColors.dark, dotHeight: 6),
            )
          ),


          // Right Arrow For Next Page
          Positioned(
            right: CSizes.defaultSpace,
            bottom: HDeviceUtils.getBottomNavigationBarHeight(),
            child: ElevatedButton(
              onPressed: ()=> OnBoardingController.instance.nextPage(),
              style: ElevatedButton.styleFrom(shape: const CircleBorder(), ),
              child: const Icon(Iconsax.arrow_right_3_copy),
            ),
          ),

        ],
      )
    );
  }
}


// Onboarding Page Class
class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.image, required this.title, required this.subtitle});

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: HHelperFunctions.screenWidth() * 0.8,
            height: HHelperFunctions.screenHeight() * 0.6,
            image: AssetImage(image),
          ),
          Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
          const SizedBox(height: CSizes.spaceBtwItems),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}