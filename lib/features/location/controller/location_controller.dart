import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rentndeal/backend_services/repositories/location_repository.dart';
import 'package:rentndeal/backend_services/repositories/user_repository.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';
import 'package:rentndeal/helpers/general_functions/network_manager.dart';
import 'package:rentndeal/helpers/popups/full_screen_loader.dart';

class LocationController extends GetxController {
  static LocationController get instance => Get.find();

  final predictions = <String>[].obs;
  final userController = Get.put(UserController());
  //final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  final _locationRepository = Get.put(LocationRepository());

  // Fetch predictions based on user input
  Future<void> fetchPredictions(String input) async {
    try {
      final prediction = await _locationRepository.fetchPlaces(input);
      predictions.assignAll(prediction);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }


// Current Location Service
  Future<String?> fetchCurrentLocation(BuildContext context) async {
    try {
      LocationDialogs.showLoadingDialog(context);
      final locationData = await _locationRepository.getCurrentLocation();
      String locationName = locationData['locationName'];
      GeoPoint geoPoint = locationData['geoPoint'];
      Navigator.of(context).pop();
 // Show location in a success dialog or use as needed
      LocationDialogs.showCurrentLocationDialog(context, locationName, geoPoint);
    } catch (e) {
      // Close the loading dialog if an error occurs
      Navigator.of(context).pop();

      // Handle specific errors and show dialogs accordingly
      if (e.toString().contains('Location service are disabled')) {
        LocationDialogs.showLocationServiceDialog(context);
      } else if (e.toString().contains('Location permissions are denied')) {
        LocationDialogs.showLocationPermissionDialog(context);
      } else {
        LocationDialogs.showErrorDialog(context);
      }
    }
    return null;
  }


// Update Location in Local Storage and DB.
  Future<void> updateLocation(String location, GeoPoint locationGeopoint) async {
    try {
      FullScreenLoader.openLoadingDialog('We are updating your information...', CImages.datasave);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> userLocation = {'Location': location, 'LocationGeopoint': locationGeopoint,};
      await userRepository.updateSingleField(userLocation);

      userController.user.value.location = location;
      userController.user.value.locationGeopoint = locationGeopoint;

      // Update local storage
    final deviceStorage = GetStorage();
    deviceStorage.write('isLocationSet', true);

      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(title: 'Contratulations', message: 'Your Location has been updated.');
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }



}