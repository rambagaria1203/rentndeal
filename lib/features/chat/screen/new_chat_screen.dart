import 'package:intl/intl.dart';
import 'package:rentndeal/backend_services/models/user_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/chat/controller/new_chat_controller.dart';
import 'package:rentndeal/features/chat/models/chat_model.dart';
import 'package:rentndeal/features/chat/screen/new_message_screen.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final chatController = Get.find<NewChatController>();
    final userId = userController.user.value.id;

    return Scaffold(
      appBar: const CustomAppBar(title: Text('Chats'), showBackArrow: false,),
      body: SafeArea(
        child: StreamBuilder<List<ChatModel>>(
          stream: chatController.loadChats(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final chats = snapshot.data;
            if (chats == null || chats.isEmpty) {
              return const Center(child: Text('No chats found'));
            }
            return ListView.separated(
              itemCount: chats.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              separatorBuilder: (_, __) => const Divider(height: 1, thickness: 1),
              itemBuilder: (context, index) {
                final chat = chats[index];
                final vendorId = chat.participants.firstWhere((id) => id != userId, orElse: () => '');
                if (vendorId.isEmpty) return const SizedBox();
                return FutureBuilder<UserModel?>(
                  future: chatController.getUserModel(userId: vendorId),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return const ListTile(title: Text('Loading...'));
                    }
                    if (!userSnapshot.hasData || userSnapshot.data == null) {
                      return const SizedBox();
                    }
                    final vendorUserModel = userSnapshot.data!;
                    final time = DateFormat('hh:mm a').format(chat.timestamp);
                    //final unreadCount = chatController.messageList.where((msg) => msg.senderId == vendorUserModel.id && !msg.isRead).length;
                    //final isUnread = unreadCount > 0;
                    final isUnread = chat.lastSenderId != userId && !chat.lastMessageIsRead;
                    return ListTile(
                      onTap: () => Get.to(() => NewMessagesScreen(productId: chat.productId, chatId: chat.chatId, userId: userId, vendorUserModel: vendorUserModel,)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      leading: Stack(
                        children: [
                          CircularImage(
                            width: 50, height: 50, padding: 0, isNetworkImage: vendorUserModel.profilePicture.isNotEmpty,
                            image: vendorUserModel.profilePicture.isNotEmpty ? vendorUserModel.profilePicture : CImages.imgProfile2,
                          ),
                          if (isUnread)
                            Positioned(right: 0, top: 0, child: Container(width: 12, height: 12, decoration: const BoxDecoration(color: CColors.primary, shape: BoxShape.circle,),),),
                        ],
                      ),
                      title: Text(vendorUserModel.fullName, style: Theme.of(context).textTheme.titleMedium),
                      subtitle: Text(chat.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle( fontSize: 14, fontWeight: isUnread ? FontWeight.bold : FontWeight.normal, color: Colors.black54,),),
                      trailing: Text(time,style: const TextStyle(fontSize: 12, color: Colors.grey),),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
