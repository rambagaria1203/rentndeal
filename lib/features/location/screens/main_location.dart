import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/location/widgets/location_list_tile.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunctions.isDarkMode(context);
    final locationController = Get.find<LocationController>();
    final userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: dark ? CColors.dark : CColors.light,
      appBar: const CustomAppBar(title: Text('Search Location'), showBackArrow: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: CSizes.spaceBtwSections / 2),

          /// ✅ Use Current Location (Top & Prominent)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace * 2),
            child: ElevatedButton(
              onPressed: () async {
                LocationDialogs.showLoadingDialog(context);
                final (status, locationData) = await locationController.fetchCurrentLocation();
                Navigator.pop(context);

                switch (status) {
                  case LocationStatus.success:
                    LocationDialogs.showCurrentLocationDialog(
                      context,
                      locationData!['locationName'],
                      locationData['geoPoint'],
                    );
                    break;
                  case LocationStatus.locationServiceDisabled:
                    LocationDialogs.showLocationServiceDialog(context);
                  case LocationStatus.permissionDenied:
                  case LocationStatus.permissionDeniedForever:
                    LocationDialogs.showLocationPermissionDialog(context);
                    break;
                  case LocationStatus.error:
                  LocationDialogs.showErrorDialog(context);
                    break;
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.my_location, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Use Current Location"),
                ],
              ),
            ),
          ),

          const SizedBox(height: CSizes.spaceBtwItems),

          /// ✅ Saved Location (if any)
          if (userController.user.value.location != null &&
              userController.user.value.location!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace * 1.5),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: fontGrey),
                  const SizedBox(width: CSizes.spaceBtwItems / 2),
                  Flexible(
                    child: Text(
                      userController.user.value.location!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: dark ? CColors.white : CColors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: CSizes.spaceBtwSections),

          /// ✅ Search Field
          SearchBarContainer(
            hintText: "Search your location",
            showBorder: true,
            borderColor: dark ? CColors.white : CColors.black,
            onChanged: (input) => locationController.fetchPredictions(input),
          ),

          const SizedBox(height: CSizes.spaceBtwItems),

          /// ✅ Prediction List or Message
          Expanded(
            child: Obx(() {
              if (locationController.predictions.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
                  child: Text(
                    "Start typing to search location...",
                    style: TextStyle(color: fontGrey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: locationController.predictions.length,
                itemBuilder: (context, index) {
                  final prediction = locationController.predictions[index];
                  return LocationListTile(
                    location: prediction['description']!,
                    press: () {locationController.handlePredictionTap(prediction['place_id']!);},
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
