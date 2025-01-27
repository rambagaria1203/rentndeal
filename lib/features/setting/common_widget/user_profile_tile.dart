import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';


class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    // New line added
    final networkImage = controller.user.value.profilePicture;
    final image = networkImage.isNotEmpty ? networkImage : CImages.imgProfile2; // Till here
    return ListTile(
      leading: CircularImage(image: image, width: 50, height: 50, padding: 0,isNetworkImage: networkImage.isNotEmpty),
      title: Obx(()=> Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: CColors.white))),
      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: CColors.white)),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit_copy, color: CColors.white),),
    );
  }
}