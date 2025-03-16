import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/location/screen/main_location.dart';
import 'package:rentndeal/features/location/controller/location_controller.dart';

class AuthLocationScreen extends StatelessWidget {
  const AuthLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(LocationController());
    precacheImage(const AssetImage(CImages.locationblue), context);
    return Scaffold(
      body: Stack(
          children: [
            BackgroundScreen(child: Column(
              children: [
                CustomAppBar(title: Text("", style: Theme.of(context).textTheme.headlineMedium!.apply(color: CColors.white,)),),
                const SizedBox(height: CSizes.defaultSpace),
              ],
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: CColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 1)],
                ),
                padding: const EdgeInsets.all(CSizes.defaultSpace ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
              
                    // Image
                    Image(image: const AssetImage(CImages.locationblue,), width: HHelperFunctions.screenWidth() * 0.6,),
                    const SizedBox(height: CSizes.spaceBtwSections),
              
                    // Title
                    Text('Search your location', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
                    const SizedBox(height: CSizes.spaceBtwItems),
                    Text('Please save your location to get better renting experience', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
                    const SizedBox(height: CSizes.spaceBtwSections),
              
                    //Button
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()async {await locationController.fetchCurrentLocation(context);}, child: const Text('Current Location')),),
                    const SizedBox(height: CSizes.spaceBtwItems * 1.5),
                    GestureDetector(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationScreen()));},
                      child: const AbsorbPointer(absorbing: true, child: SearchBarContainer(hintText: "Search your location", padding: EdgeInsets.symmetric(horizontal: CSizes.defaultSpace / 8),))
                    ),
                  ],
                ),
              )
            ) ,
            
          ]
        ),
    );
  }
}