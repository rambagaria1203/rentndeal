import 'package:http/http.dart' as http;
import 'package:rentndeal/constants/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationRepository implements ILocationRepository {
  final _googleApiKey = ApiConstants.gooleLocationAPIKey;

  @override
//-------------------------------------------------PREDICT USER LOCATION BASED ON SEARCH INPUT----------------------------------------------------------//
  Future<List<Map<String, String>>> fetchPredictions(String input) async {
    if (input.isEmpty) {
      return [];
    }
    final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$_googleApiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'OK') {
        return (jsonData['predictions'] as List).map((p) => {'description': p['description'] as String, 'place_id': p['place_id'] as String}).toList();
      } else {
        throw Exception('Google API Error: ${jsonData['status']}');
      }
    } else {
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  }

//-------------------------------------------------USER SEARCH LOCATION COORDINATES----------------------------------------------------------//
  @override
  Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    final url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_googleApiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'OK') {
        final result = jsonData['result'];
        final lat = result['geometry']['location']['lat'];
        final lng = result['geometry']['location']['lng'];
        final name = result['name'];
        final address = result['formatted_address'];
      return {
        'locationName': "$name, $address",
        'geoPoint': GeoPoint(lat, lng)
      };
    }
    throw Exception('Failed to fetch place details: ${jsonData['status']}');
  } else {
    throw Exception('Failed to fetch place details. Status code: ${response.statusCode}');
  }
}

//----------------------------------------------------------USER CURRENT LOCATION---------------------------------------------------------------------------------//
  @override
  Future<Map<String, dynamic>> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String locationName = "${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}";
    return {
      'locationName': locationName,
      'geoPoint': GeoPoint(position.latitude, position.longitude)
    };
  }

//-------------------------------------------------END----------------------------------------------------------//
}