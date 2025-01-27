import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/location/controller/location_controller.dart';

class LocationDialogs {

  final locationController = Get.put(LocationController);

// Dialog when Location permission of the device if off.
static showLocationServiceDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Location Service Disabled'),
        content: const Text('Please enable location services to use this feature.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


// Dialog when location Permission is denied for the application.
static showLocationPermissionDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Denied'),
          content:const  Text('Please grant location permissions to use this feature.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


// Loading Dialog to get user current location
  static showLoadingDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Getting your location..."),
            ],
          ),
        );
      },
    );
  }


// Error while fetching current location
  static showErrorDialog(context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occured while fetching the location.'),
          actions: [
            TextButton(child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },)
          ],
        );
      }
    );
  }

// Dialog to Display current location.
  static showCurrentLocationDialog(context, location, geoPoint) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Current Location'),
            content: Text(location),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () {Navigator.of(context).pop();}, child: const Text('Cancel', style: TextStyle(fontSize: 16),)),
                  TextButton(onPressed: () async {LocationController.instance.updateLocation(location, geoPoint);}, child: const Text('OK', style: TextStyle(fontSize: 16))),
                ],
                
              ),
            ],
          );
        },
      );
  }

}
