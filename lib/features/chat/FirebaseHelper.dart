import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentndeal/backend_services/models/user_model.dart';

class FirebaseHelper {
  static Future<UserModel?> getUserModelById(String id) async {
    UserModel? userModel;

    DocumentSnapshot<Map<String, dynamic>> docSnap = await FirebaseFirestore.instance.collection('users').doc(id).get();
    if (docSnap.data() != null) {
      userModel = UserModel.fromSnapshot(docSnap);

    }
    return userModel;
  }
}