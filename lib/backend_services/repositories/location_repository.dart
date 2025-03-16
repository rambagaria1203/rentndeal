import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:rentndeal/constants/api_constants.dart';
import 'package:rentndeal/constants/consts.dart';

class LocationRepository extends GetxController {
  static LocationRepository get instance => Get.find();

  final _googleApiKey = ApiConstants.gooleLocationAPIKey;

//-------------------------------------------------Predict User Location Based on Search----------------------------------------------------------//
  Future<List<String>> fetchPredictions(String input) async {
    if (input.isEmpty) {
      return [];
    }
    final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$_googleApiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'OK') {
        final predictions = jsonData['predictions'] as List;
        return predictions.map((prediction) => prediction['description'] as String).toList();
      } else {
        throw Exception('Failed to fetch predictions: ${jsonData['status']}');
      }
    } else {
      throw Exception('Failed to fetch predictions. status code: ${response.statusCode}');
    }
  }

//Dummy function------------------------------------------------------------------------------------------------------------------
  Future<List<String>> fetchPlaces(String input) async {
  if (input.isEmpty) {
    return [];
  }

  // Return hardcoded predictions for testing purposes
  final mockPredictions = [
    "New York, USA",
    "London, UK",
    "Tokyo, Japan",
    "Sydney, Australia",
    "Paris, France",
    "Mumbai, India",
    "Berlin, Germany",
    "Toronto, Canada",
    "Dubai, UAE",
    "Cape Town, South Africa"
  ];

  // Simulate a network delay
  await Future.delayed(const Duration(seconds: 1));

  return mockPredictions.where((place) => place.toLowerCase().contains(input.toLowerCase())).toList();
}


//-------------------------------------------------Predict User Location Based on Search----------------------------------------------------------//
  Future<Map<String, dynamic>> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String locationName = "${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}";
    return {
      'locationName': locationName,
      'geoPoint': GeoPoint(position.latitude, position.longitude)
    };
  }
}