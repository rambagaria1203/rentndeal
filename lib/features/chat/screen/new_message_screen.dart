import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rentndeal/backend_services/models/user_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/chat/controller/new_chat_controller.dart';
import 'package:rentndeal/features/chat/models/chat_model.dart';

class NewMessagesScreen extends StatefulWidget {
  final String chatId;
  final String productId;
  final String userId;
  final UserModel vendorUserModel;

  const NewMessagesScreen({super.key, required this.chatId, required this.productId, required this.userId, required this.vendorUserModel});

  @override
  State<NewMessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<NewMessagesScreen> {
  late String _chatId;
  bool isFromProductScreen = false;
  final TextEditingController messageController = TextEditingController();
  final NewChatController chatController = Get.find<NewChatController>();
  
  @override
  void initState() {
    super.initState();
    _chatId = widget.chatId;
    isFromProductScreen = _chatId.isEmpty;
    if (!isFromProductScreen) {
      chatController.loadMessages(_chatId);
      chatController.markUnreadMessagesAsRead(_chatId, widget.userId);
    }
  }
  void _sendMessage() async {
    bool isMessageSeen = false;
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    if (isFromProductScreen && _chatId.isEmpty) {
      _chatId = await chatController.getOrCreateChatId(productId: widget.productId, userId: widget.userId, vendorId: widget.vendorUserModel.id,) ?? '';
      if (_chatId.isEmpty) return;
      chatController.loadMessages(_chatId);
      chatController.markUnreadMessagesAsRead(_chatId, widget.userId);
      isMessageSeen = true;
    }
    if (!isMessageSeen) {
      await chatController.markUnreadMessagesAsRead(_chatId, widget.userId);
    }
    final message = MessageModel(senderId: widget.userId, text: text, timestamp: DateTime.now(),isRead: false, type: 'text');
    await chatController.sendMessage(_chatId, message);
    messageController.clear();
  }

  Future<void> _pickAndSendImage() async {
    bool isMessageSeen = false;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      if (isFromProductScreen && _chatId.isEmpty) {
        _chatId = await chatController.getOrCreateChatId(productId: widget.productId, userId: widget.userId, vendorId: widget.vendorUserModel.id) ?? '';
        if (_chatId.isEmpty) return;
        chatController.loadMessages(_chatId);
        chatController.markUnreadMessagesAsRead(_chatId, widget.userId);
        isMessageSeen = false;
      }
      if (!isMessageSeen) {
      await chatController.markUnreadMessagesAsRead(_chatId, widget.userId);
      }
      final imageUrl = await chatController.uploadChatImage(imageFile, _chatId);
      final message = MessageModel(senderId: widget.userId, text: '[Image]', imageUrl: imageUrl, timestamp: DateTime.now(), isRead: false, type: 'image');
      await chatController.sendMessage(_chatId, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircularImage(
              width: 45, height: 45, padding: 0, isNetworkImage: widget.vendorUserModel.profilePicture.isNotEmpty,
              image: widget.vendorUserModel.profilePicture.isNotEmpty ? widget.vendorUserModel.profilePicture : CImages.imgProfile2, 
            ),
            const SizedBox(width: 10),
            Text(widget.vendorUserModel.fullName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                itemCount: chatController.messageList.length,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                itemBuilder: (context, index) {
                  final message = chatController.messageList.reversed.toList()[index];
                  final isMe = message.senderId == widget.userId;
                  Widget messageContent;
                  if (message.type == 'image') {
                    messageContent = ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(message.imageUrl ?? message.text, width: 200),);
                  } else if (message.type == 'emoji') {
                    messageContent = Text(message.text, style: const TextStyle(fontSize: 26));
                  } else {
                    messageContent = Text(message.text, style: const TextStyle(color: Colors.white, fontSize: 16),);
                  }
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: isMe ? Colors.grey[700] : Theme.of(context).colorScheme.primary),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          messageContent,
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(DateFormat('h:mm a').format(message.timestamp), style: const TextStyle(fontSize: 10, color: Colors.white70),),
                              const SizedBox(width: 4),
                              if (isMe)
                                Icon(message.isRead ? Icons.done_all : Icons.check, size: 16, color: message.isRead ? Colors.lightBlue : Colors.white70,)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(child: TextField(controller: messageController, maxLines: null, decoration: const InputDecoration(hintText: 'Type a message...'),),),
                IconButton(icon: const Icon(Icons.image, color: Colors.green), onPressed: _pickAndSendImage,),
                const SizedBox(width: 4),
                IconButton(icon: Icon(Icons.send, color: Theme.of(context).colorScheme.primary), onPressed: _sendMessage,),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    print("****************************************************************************************************************************************************************");
    chatController.markUnreadMessagesAsRead(_chatId, widget.userId);
    super.dispose();
  }
}
