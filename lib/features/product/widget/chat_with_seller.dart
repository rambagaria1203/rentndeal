import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/constants/sizes.dart';
import 'package:rentndeal/features/Chat_screen/controller/chat_controller.dart';
import 'package:rentndeal/features/Chat_screen/screen/chat_screen.dart';

class SellerChatButton extends StatelessWidget {
  final String sellerName;
  final String currentUserId;
  final String sellerUserId;
  //final VoidCallback onTap;

  const SellerChatButton({
    super.key, 
    required this.sellerName,
    required this.currentUserId,
    required this.sellerUserId
    //required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    final  controller = Get.put(ChatController());
    return Padding(
      padding: const EdgeInsets.only(bottom: CSizes.defaultSpace/2, top: CSizes.defaultSpace/4, left: CSizes.defaultSpace /2, right: CSizes.defaultSpace/2),
        child: GestureDetector(
        onTap: () async{
          final chatroom = await controller.getOrCreateChatRoom(currentUserId: currentUserId, targetUserId: sellerUserId);
          final sellerUser = await controller.getUserModel(userId: sellerUserId);
          final currentUser = await controller.getUserModel(userId: currentUserId);
          Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatRoomScreen(targetUser: sellerUser, chatroom: chatroom, userModel: currentUser)));
        },
        child: Container(
          width: double.infinity, height: 65,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1E1E1E), Color(0xFF3A3A3A)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 12, spreadRadius: 1, offset: const Offset(0, 4),),],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.message, color: Colors.white, size: 28),
                const SizedBox(width: 10),
                Flexible(child: Text("Chat with $sellerName", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 1,), maxLines: 1, overflow: TextOverflow.ellipsis,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
