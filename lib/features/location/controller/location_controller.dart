import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentndeal/backend_services/repositories/location_repository.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';

class LocationController extends GetxController {
  static LocationController get instance => Get.find();

  final predictions = <String>[].obs;
  final userController = Get.put(UserController());
  final _locationRepository = Get.put(LocationRepository());

//-------------------------------------------------User Location Based on Search Controller----------------------------------------------------------//
  Future<void> fetchPredictions(String input) async {
    try {
      final prediction = await _locationRepository.fetchPlaces(input);
      predictions.assignAll(prediction);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

//-------------------------------------------------User Current Location Controller--------------------------------------------------------------//
  Future<String?> fetchCurrentLocation(BuildContext context) async {
    try {
      LocationDialogs.showLoadingDialog(context);
      if (!await Geolocator.isLocationServiceEnabled()) {
        Navigator.of(context).pop();
        LocationDialogs.showLocationServiceDialog(context);
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Navigator.of(context).pop();
          LocationDialogs.showLocationPermissionDialog(context);
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Navigator.of(context).pop();
        LocationDialogs.showLocationPermissionDialog(context);
        return null;
      }
      final locationData = await _locationRepository.getCurrentLocation();
      String locationName = locationData['locationName'];
      GeoPoint geoPoint = locationData['geoPoint'];
      Navigator.of(context).pop();
      LocationDialogs.showCurrentLocationDialog(context, locationName, geoPoint);
    } catch (e) {
      Navigator.of(context).pop();
      LocationDialogs.showErrorDialog(context);
    }
    return null;
  }

//-------------------------------------------------User Update Location----------------------------------------------------------------------------------------------------//
  Future<void> updateLocation(String location, GeoPoint locationGeopoint) async {
    await userController.updateUserLocation(location, locationGeopoint);
  }

}