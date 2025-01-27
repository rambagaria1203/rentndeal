
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/login_controller.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: CColors.grey), borderRadius: BorderRadius.circular(150)),
          child: IconButton(onPressed: () => controller.googleSignIn(), icon: const Image(width: CSizes.iconLg, height: CSizes.iconLg, image: AssetImage(CImages.icGoogleLogo),))
        )
      ],
    );
  }
}