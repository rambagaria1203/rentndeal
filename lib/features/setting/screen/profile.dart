import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/common_function/loaders/shimmer_effect.dart';
import 'package:rentndeal/features/setting/screen/change_name.dart';

class ProfileS extends StatelessWidget {
  const ProfileS({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const CustomAppBar(showBackArrow: true, title: Text('Profile')),

      ///----Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              ///----Profile Picture
              SizedBox(width: double.infinity,
              child: Column(
                children: [
                  Obx(() {
                    final networkImage = controller.user.value.profilePicture;
                    final image = networkImage.isNotEmpty ? networkImage : CImages.imgProfile2;
                    return controller.imageUploading.value
                      ? const ShimmerEffect(width: 80, height: 80, radius: 80)
                      : CircularImage(image: image, width: 80, height: 80, isNetworkImage: networkImage.isNotEmpty);
                  }), 
                  TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),

                ]
              ),
              ),

              /// Details
              const SizedBox(height: CSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems),
              const SectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: CSizes.spaceBtwItems),

              ProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: () => Get.to(() => const ChangeName())),
              ProfileMenu(title: 'Email', value: controller.user.value.email, onPressed: (){}),
              ProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNumber, onPressed: (){},),
              ProfileMenu(title: 'Location', value: controller.user.value.location ?? '', onPressed: (){},),
              ProfileMenu(title: 'Password', value: '********', onPressed: (){},),

              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems),

              Center(
                child: TextButton(onPressed: () => controller.deleteAccountWarningPopup(), child: const Text('Close Account', style: TextStyle(color: Colors.red),),)
              )

            ],

          ),),

      )
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_3_copy
  });

  final IconData icon;
  final String title, value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(title, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,)),
            Expanded(flex: 5, child: Text(value, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis,)),
            Expanded(child: Icon(icon, size: 18,))
          ],
        ),
      ),
    );
  }
}