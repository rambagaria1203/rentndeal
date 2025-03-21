import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentndeal/backend_services/models/chatroom_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:uuid/uuid.dart';

class ChatRepository extends GetxController {
  static ChatRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();


// Currently Unused Query
  Stream<List<ChatRoomModel>> getChatRooms(String userId) {
    final snapshot = _db.collection('chats').where('participants.$userId', isEqualTo: true).snapshots();
    return snapshot.map((snapshot) => snapshot.docs.map((doc) => ChatRoomModel.fromSnapshot(doc.data())).toList());
  }

//Get extisting chat room
  Future<ChatRoomModel?> fetchChatRoom({required String currentUserId, required String targetUserId}) async {
    try {
      QuerySnapshot snapshot = await _db.collection('chats').where('participants.$currentUserId', isEqualTo: true).where('participants.$targetUserId', isEqualTo: true).get();
      if (snapshot.docs.isNotEmpty) {
        return ChatRoomModel.fromSnapshot(snapshot.docs.first.data() as Map<String, dynamic>);
      }
      return null;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

// Create New chatroom
  Future<ChatRoomModel> createChatRoom({required String currentUserId, required String targetUserId}) async {
    try {
      ChatRoomModel newChatRoom = ChatRoomModel(
        chatroomid: _uuid.v1(),
        lastMessage: "",
        participants: {
          currentUserId: true,
          targetUserId: true
        }
      );
      await _db.collection('chats').doc(newChatRoom.chatroomid).set(newChatRoom.toJson());
      return newChatRoom;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  
}