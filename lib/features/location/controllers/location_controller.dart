import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';
import 'package:rentndeal/helpers/popups/full_screen_loader.dart';

class LocationController extends GetxController {
  static LocationController get instance => Get.find();

  final ILocationRepository repository;
  final predictions = <Map<String, String>>[].obs;
  final userController = UserController.instance;

  LocationController({required this.repository});

//-------------------------------------------------LOCATION BASED ON SEARCH INPUT CONTROLLER----------------------------------------------------------//
  Future<void> fetchPredictions(String input) async {
    if (input.trim().isEmpty) {
      predictions.clear();
      return;
    }
    try {
      final prediction = await repository.fetchPredictions(input);
      predictions.assignAll(prediction);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

//-------------------------------------------------SEARCHED LOCATION COORDINATES CONTROLLER--------------------------------------------------------------//
  Future<void> handlePredictionTap(String placeId) async {
  try {
    FullScreenLoader.openLoadingDialog('We are updating your information...', CImages.datasave);
    final placeDetails = await repository.getPlaceDetails(placeId);
    //FullScreenLoader.stopLoading();
    await updateLocation(placeDetails['locationName'], placeDetails['geoPoint']);
  } catch (e) {
    FullScreenLoader.stopLoading();
    Loaders.errorSnackBar(title: 'Failed to update location', message: e.toString());
  }
}

//-------------------------------------------------CURRENT LOCATION CONTROLLER--------------------------------------------------------------//
  Future<(LocationStatus, Map<String, dynamic>?)> fetchCurrentLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return (LocationStatus.locationServiceDisabled, null);
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          return (LocationStatus.permissionDenied, null);
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return (LocationStatus.permissionDeniedForever, null);
      }
      final locationData = await repository.getCurrentLocation();
      return (LocationStatus.success, locationData);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
      return (LocationStatus.error, null);
    }
  }

//-------------------------------------------------UPDATE USER DATA----------------------------------------------------------------------------------------------------//
  Future<void> updateLocation(String location, GeoPoint geopoint) async {
    await userController.updateUserLocation(location, geopoint);
  }

//-------------------------------------------------END----------------------------------------------------------------------------------------------------//

}