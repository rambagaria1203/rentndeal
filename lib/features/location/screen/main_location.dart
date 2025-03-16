import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/location/controller/location_controller.dart';

class LocationScreen extends StatelessWidget {
  //final bool userlocation;
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunctions.isDarkMode(context);

    final locationController = Get.put(LocationController());
    final userController = Get.put(UserController());
    
    return Scaffold(
      backgroundColor: dark ? CColors.dark : CColors.light,
      appBar: const CustomAppBar(title: Text(' Search Location'), showBackArrow: true),
      body: Column(
        children: [
        const SizedBox(height: CSizes.spaceBtwSections / 2),
        SearchBarContainer(hintText: "Search your location", showBorder: true, borderColor: dark ?CColors.white : CColors.black, onChanged: (input){
          locationController.fetchPredictions(input);
        },),
        const SizedBox(height: CSizes.spaceBtwSections),
// Current Location Button
        const Divider(height: 0.5, thickness: 0.5,color: fontGrey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace * 2, vertical: CSizes.defaultSpace / 3),
          child: ElevatedButton(onPressed: ()async {
            await locationController.fetchCurrentLocation(context);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_pin, color: CColors.white, size: 20),
              SizedBox(width: CSizes.spaceBtwItems / 4),
              Text("Current Location"),
            ],
          ),
          ),
        ),
        const Divider(height: 0.5, thickness: 0.5,color: fontGrey),


        // Prediction List
        Expanded(
          child: Obx(() {
            if (locationController.predictions.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: CSizes.defaultSpace / 1.5, left: CSizes.defaultSpace/ 1.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (userController.user.value.location != null && userController.user.value.location!.isNotEmpty) ...[
                      Icon(Icons.location_on, color: dark? CColors.white : CColors.black),
                      const SizedBox(width: CSizes.spaceBtwItems / 2),
                      Flexible(child: Text(userController.user.value.location!, style: Theme.of(context).textTheme.titleMedium!.apply(color: CColors.black),maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis,))
                    ]
                  ],
                  ),
              );
            }
            return ListView.builder(
              itemCount: locationController.predictions.length,
              itemBuilder: (context, index) {
                final prediction = locationController.predictions[index];
                return ListTile(
                  leading: Icon(Icons.location_on, color: dark? CColors.white : CColors.black),
                  title: Text(prediction, style: TextStyle(color: dark? CColors.white : CColors.black)),
                  onTap: () {
                    if (kDebugMode) {
                      print('Selected Prediction: $prediction');
                    }
                  },
                );
              });
          }) )
        ]
      ),
    );
  }
}