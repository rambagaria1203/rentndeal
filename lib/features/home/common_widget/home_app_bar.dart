import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/common_function/loaders/shimmer_effect.dart';
import 'package:rentndeal/features/location/screen/main_location.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return CustomAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          const Icon(Iconsax.location, color: CColors.white, size: CSizes.defaultSpace/1.5),
          const SizedBox(width: 3),
          Flexible(
            child: SizedBox(
              width: HHelperFunctions.screenWidth()*0.4,
              child: Obx(() {
                if (controller.profileLoading.value) {
                  return const ShimmerEffect(width: 80, height: 15);
                } else {
                  return Text( (controller.user.value.location != null && controller.user.value.location!.isNotEmpty) ? controller.user.value.location! : "Choose Your Location", style: Theme.of(context).textTheme.bodyLarge!.apply(color: CColors.grey),maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis,);}
                }
              )
            ),
          )
        ] 
      ).onTap(() {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationScreen()),
    ); }),
    //-------
    // Notification Icon
    actions: [
      Stack(
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Iconsax.notification, color: CColors.white)),
          Positioned(
            right: 0,
            child: Container(
              width: 18, height: 18,
              decoration: BoxDecoration(color: CColors.black, borderRadius: BorderRadius.circular(100)),
              child: Center(child: Text("2", style: Theme.of(context).textTheme.labelLarge!.apply(color:CColors.white, fontSizeFactor: 0.8)),),
            ),
          )
        ]
      )
    ],
    );
  }
}