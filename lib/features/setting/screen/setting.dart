import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';
import 'package:rentndeal/features/setting/common_widget/user_profile_tile.dart';
import 'package:rentndeal/features/vendor_page/screen/my_product.dart';

class SettingS extends StatelessWidget {
  const SettingS({super.key});

  @override
  Widget build(BuildContext context) {
    //final categoryData = CategoryRepository.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// --- Header
            BackgroundScreen(child: Column(
              children: [
                CustomAppBar(title: Text("Account", style: Theme.of(context).textTheme.headlineMedium!.apply(color: CColors.white)),),
                
                /// User Profile Card
                UserProfileTile(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileS()),);
                },),
                const SizedBox(height: CSizes.spaceBtwSections,)
              ],
            )
            ),
            /// ---Body
            Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: Column(
                children: [
                  /// --- Account Setting
                  const SectionHeading(title: 'Account Setting', showActionButton: false,),
                  const SizedBox(height: CSizes.spaceBtwItems,),

                  //SettingMenuTile(title: 'My Address', icon: Iconsax.safe_home, subtitle: 'Set shopping delivery address', onTap: (){Get.to(() => const AuthLocationScreen(), binding: LocationBinding());},),
                  SettingMenuTile(title: 'My Wishlist', icon: Iconsax.safe_home, subtitle: 'Set shopping delivery address', onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const FavouriteScreen(),));},),
                  SettingMenuTile(title: 'My Products', icon: Iconsax.safe_home, subtitle: 'Set shopping delivery address', onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProductScreen(),));},),
                  SettingMenuTile(title: 'Notification', icon: Iconsax.notification, subtitle: 'Set any kind of notification message', onTap: ()=> Loaders.errorSnackBar(title: "This feature is currently unavailable. Sorry for the inconvenience."),),
                  SettingMenuTile(title: 'Account Privacy', icon: Iconsax.security_card, subtitle: 'Manage data usage and connected accounts', onTap: ()=> Loaders.errorSnackBar(title: "This feature is currently unavailable. Sorry for the inconvenience."),),


                  /// -- App Setting
                  const SizedBox(height: CSizes.spaceBtwItems),
                  const SectionHeading(title: 'App Setting', showActionButton: false),
                  const SizedBox(height: CSizes.spaceBtwItems),
                  SettingMenuTile(title: 'Load Data', icon: Iconsax.document_upload, subtitle: 'Upload Data to your Cloud Firebase', onTap: ()=> Loaders.errorSnackBar(title: "This feature is currently unavailable. Sorry for the inconvenience.")),
                  SettingMenuTile(title: 'Geolocation', icon: Iconsax.location, subtitle: 'Set recommendation based on location', trailing: Switch(value: true, onChanged: (value) {}),),
                  
                  /// --- Logout Button
                  const SizedBox(height: CSizes.spaceBtwSections),
                  SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => AuthenticationRepository.instance.logout(), child: const Text('Logout'),)),
                  const SizedBox(height: CSizes.spaceBtwSections * 3)
                ],
              ),)
          ],
        ),
      ),
    );
  }
}

