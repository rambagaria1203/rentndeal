import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String email;
  String phoneNumber;
  String? location;
  GeoPoint? locationGeopoint;
  String profilePicture;

  // Constructor for UserModel
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.location,
    this.locationGeopoint,
    required this.profilePicture,
  });

  // Helper function to UserModel
  String get fullName => '$firstName $lastName';

  // Function to split full name to first & last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  // Static function to create an empty user model
  static UserModel empty() => UserModel(id: '', firstName: '', lastName: '', email: '', phoneNumber: '', location: null, locationGeopoint: null, profilePicture: '');

  // Convert model to Json structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Location': location ?? '',
      'LocationGeopoint': locationGeopoint ?? '',
      'ProfilePicture': profilePicture,
    };
  }

  // Method to create a usermodel from a firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        location: data['Location'] ?? '',
        locationGeopoint: data['LocationGeopoint'] != null ? data['LocationGeopoint'] as GeoPoint : null,
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
    throw Exception('Document data is null');
  }
  }
}