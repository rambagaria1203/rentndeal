import 'package:rentndeal/constants/consts.dart';
import 'package:geocoding/geocoding.dart' as geocoding;


class LocationService {
  static Future<String> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude, position.longitude);

    String currentLocation =
        "${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}";

    return currentLocation;
  }


  void getCurrentLocationAndUpdate(context) async {
    LocationDialogs.showLoadingDialog(context);
    try {
      //var currentLocation = await getCurrentLocation();
      //locationController.updateLocation(currentLocation);
      Navigator.of(context).pop();
      Get.back();
    } catch (e) {
      Navigator.of(context).pop();

      if (e.toString().contains('Location services are disabled')) {
        LocationDialogs.showLocationServiceDialog(context);
      } else if (e.toString().contains('Location permissions are denied') || e.toString().contains('Location permissions are permanently denied')) {
        LocationDialogs.showLocationPermissionDialog(context);
      } else {
        LocationDialogs.showErrorDialog(context);
      }
    }
  }

  void getCurrentLocationAndNavigateToSignup(context) async {
    LocationDialogs.showLoadingDialog(context);
    try {
      //var currentLocation = await getCurrentLocation();
      //locationController.updateLocation(currentLocation);
      Navigator.of(context).pop();
      //Get.to(() => SignupScreen(location: currentLocation)); // Navigate to SignupScreen with location
    } catch (e) {
      Navigator.of(context).pop();

      if (e.toString().contains('Location services are disabled')) {
        LocationDialogs.showLocationServiceDialog(context);
      } else if (e.toString().contains('Location permissions are denied') || e.toString().contains('Location permissions are permanently denied')) {
        LocationDialogs.showLocationPermissionDialog(context);
      } else {
        LocationDialogs.showErrorDialog(context);
      }
    }
  }
}