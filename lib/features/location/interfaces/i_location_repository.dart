abstract class ILocationRepository {
  Future<List<Map<String, String>>> fetchPredictions(String input);
  Future<Map<String, dynamic>> getCurrentLocation();
  Future<Map<String, dynamic>> getPlaceDetails(String placeId);
}