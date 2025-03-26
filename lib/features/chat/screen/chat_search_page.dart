import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentndeal/backend_services/models/chatroom_model.dart';
import 'package:rentndeal/backend_services/models/user_model.dart';
import 'package:rentndeal/constants/images.dart';
import 'package:rentndeal/features/chat/screen/chat_screen.dart';
import 'package:rentndeal/features/common_function/custom_appbar/custom_appbar.dart';
import 'package:rentndeal/features/common_function/image_text_widgets/circular_image.dart';
import 'package:uuid/uuid.dart';

class ChatSearchPage extends StatefulWidget {
  final UserModel userModel;
  const ChatSearchPage({super.key, required this.userModel});


  @override
  State<ChatSearchPage> createState() => _ChatSearchPageState();
}

class _ChatSearchPageState extends State<ChatSearchPage> {
  var uuid = const Uuid();

  TextEditingController searchController = TextEditingController();

  Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {

    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('chats').where('participants.${widget.userModel.id}', isEqualTo: true).where('participants.${targetUser.id}', isEqualTo: true).get();

    if(snapshot.docs.isNotEmpty) {


      // fetch the existing data
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom = ChatRoomModel.fromSnapshot(docData as Map<String, dynamic>);
      chatRoom = existingChatroom;

    } else {
      // create a new chatroom
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        participants: {widget.userModel.id.toString(): true, targetUser.id.toString(): true}
      );
      await FirebaseFirestore.instance.collection('chats').doc(newChatroom.chatroomid).set(newChatroom.toJson());
      chatRoom = newChatroom;
  }
  return chatRoom;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Search'), showBackArrow: true, 
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(labelText: "Email Address"),
              ),
              const SizedBox(height: 20),
              CupertinoButton(onPressed: () { setState(() {});}, color: Theme.of(context).colorScheme.secondary, child: const Text("Search")),
              const SizedBox(height: 20,),

              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').where('Email', isEqualTo: searchController.text).snapshots() ,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if(snapshot.hasData) {
                      QuerySnapshot<Object?> dataSnapshot = snapshot.data as QuerySnapshot<Object?>;
                      if(dataSnapshot.docs.isNotEmpty) {
                        QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot =dataSnapshot.docs[0] as QueryDocumentSnapshot<Map<String, dynamic>>;
                        UserModel searchedUser = UserModel.fromSnapshot(documentSnapshot);

                        final networkImage = searchedUser.profilePicture;
                        final image = networkImage.isNotEmpty ? networkImage : CImages.imgProfile2;

                        return ListTile(
                          onTap: () async {
                            ChatRoomModel? chatroomModel = await getChatroomModel(searchedUser);

                            if(chatroomModel != null) {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ChatRoomScreen(targetUser: searchedUser, userModel: widget.userModel, chatroom: chatroomModel);} ));
                            }
                          
                          },
                          leading: CircularImage(image: image, width: 50, height: 50, padding: 0,isNetworkImage: networkImage.isNotEmpty),
                          title: Text(searchedUser.fullName.toString()),
                          subtitle: Text(searchedUser.email.toString()),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        );
                      }
                      else {
                        return const Text('No result found!');
                      }
                    } else if(snapshot.hasError) {
                      return const Text('An error occured!');
                    }else {
                      return const Text('No result found!');
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                }))
              
            ],
          ),
        )),
    );
  }
}