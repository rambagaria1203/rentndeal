import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rentndeal/backend_services/models/chatroom_model.dart';
import 'package:rentndeal/backend_services/models/user_model.dart';
import 'package:rentndeal/constants/colors.dart';
import 'package:rentndeal/constants/images.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/Chat_screen/FirebaseHelper.dart';
import 'package:rentndeal/features/Chat_screen/screen/chat_screen.dart';
import 'package:rentndeal/features/Chat_screen/screen/chat_search_page.dart';
import 'package:rentndeal/features/common_function/custom_appbar/custom_appbar.dart';
import 'package:rentndeal/features/common_function/image_text_widgets/circular_image.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: CustomAppBar(
          title: Text('Messages', style: Theme.of(context).textTheme.headlineMedium),
        ),
      body:  SafeArea(
        child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats').where('participants.${controller.user.value.id}', isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              QuerySnapshot chatRoomSnashot = snapshot.data as QuerySnapshot;
              
              return ListView.builder(
                itemCount: chatRoomSnashot.docs.length,
                itemBuilder: (context, index) {
                  ChatRoomModel chatRoomModel = ChatRoomModel.fromSnapshot(chatRoomSnashot.docs[index].data() as Map<String, dynamic>);
                  Map<String, dynamic> participants = chatRoomModel.participants!;
                  List<String> participantKeys = participants.keys.toList();
                  participantKeys.remove(controller.user.value.id);
          
                  return FutureBuilder(
                    future: FirebaseHelper.getUserModelById(participantKeys[0]),
                    builder: (context, userData) {
                      if (userData.connectionState == ConnectionState.done) {
      
                        if (userData.data != null) {
                          UserModel targetUser = userData.data as UserModel;
      
                          return ListTile(
                            tileColor: Colors.grey[200],
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ChatRoomScreen(targetUser: targetUser, chatroom: chatRoomModel, userModel: controller.user.value);
                              }));
                            },
                            leading: CircularImage(image: targetUser.profilePicture.isNotEmpty ? targetUser.profilePicture : CImages.imgProfile2, width: 50, height: 50, padding: 0,isNetworkImage: targetUser.profilePicture.isNotEmpty,),
                            title: Text(targetUser.fullName.toString()),
                            subtitle: Text(chatRoomModel.lastMessage.toString()),
                          );
                        } else {
                          return Container();
                        }
                        
                      } else {
                        return Container();
                      }
                    } 
                    );
      
                });
      
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
      
            } else {
              return const Center(child: Text("No Chats"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatSearchPage(userModel: controller.user.value);
        }));
      }, backgroundColor: CColors.primary, child: const Icon(Icons.search, color: whiteColor, size: 28,),),
    );
  }
}