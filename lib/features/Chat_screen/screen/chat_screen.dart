import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentndeal/backend_services/models/chatroom_model.dart';
import 'package:rentndeal/backend_services/models/message_model.dart';
import 'package:rentndeal/backend_services/models/user_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:uuid/uuid.dart';

class ChatRoomScreen extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatroom;
  final UserModel userModel;
  const ChatRoomScreen({super.key, required this.targetUser, required this.chatroom, required this.userModel});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {

  TextEditingController messageController = TextEditingController();
  final uuid = const Uuid();

  void sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();
    if(msg !="") {
      //send message
      MessageModel newMessage = MessageModel(
        messageid: uuid.v1(),
        sender: widget.userModel.id,
        seen: false,
        createdon: DateTime.now(),
        text: msg
      );

      FirebaseFirestore.instance.collection('chats').doc(widget.chatroom.chatroomid).collection('messages').doc(newMessage.messageid).set(newMessage.toJson());
      widget.chatroom.lastMessage = msg;
      FirebaseFirestore.instance.collection('chats').doc(widget.chatroom.chatroomid).set(widget.chatroom.toJson());
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          CircularImage(image: widget.targetUser.profilePicture.isNotEmpty ? widget.targetUser.profilePicture : CImages.imgProfile2, width: 50, height: 50, padding: 0, isNetworkImage: widget.targetUser.profilePicture.isNotEmpty,),
          const SizedBox(width: 10),
          Text(widget.targetUser.fullName.toString()),
        ],),
      ),
      body: SafeArea(
        child: Column(
          children: [
        
            // This is where the chat will go
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('chats').doc(widget.chatroom.chatroomid).collection('messages').orderBy('createdon', descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.active){
                      if(snapshot.hasData) {
                        QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
        
                        return ListView.builder(
                          reverse: true,
                          itemCount: dataSnapshot.docs.length,
                          itemBuilder: (context, index) {
                            MessageModel currentMessage = MessageModel.fromSnapshot(dataSnapshot.docs[index].data() as Map<String, dynamic>);
                            
                            return Row(
                              mainAxisAlignment: currentMessage.sender == widget.userModel.id ? MainAxisAlignment.end : MainAxisAlignment.start,
                              children:[ Container(
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                decoration: BoxDecoration(color: currentMessage.sender == widget.userModel.id ? Colors.grey : Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(8)),
                                child: Text(currentMessage.text.toString(), style: const TextStyle(color: Colors.white, fontSize: 16),)),
                              ],
                            );
                          });
        
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('An error occured! Please check you internet connection'),);
        
                      } else {
                        return const Center(child: Text('Say hi to your friend'),);
                      }
        
                    }else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
                ),
        
              )
            ),
        
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
              children: [
                Flexible(
                child: TextField(
                  controller: messageController,
                  maxLines: null,
                  decoration: const InputDecoration(hintText: "Enter message"),)
                ),
                IconButton(onPressed: (){sendMessage();}, icon: Icon(Icons.send, color: Theme.of(context).colorScheme.secondary,))
              
              ],
            ),)
            
          ],
        )),
    );
  }
}