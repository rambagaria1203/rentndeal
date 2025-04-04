import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/chat/screen/new_message_screen.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/features/chat/controller/new_chat_controller.dart';


class SellerChatButton extends StatelessWidget {
  final ProductModel product;
  final String userId;

  const SellerChatButton({super.key, required this.product, required this.userId});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CSizes.defaultSpace/2, top: CSizes.defaultSpace/4, left: CSizes.defaultSpace /2, right: CSizes.defaultSpace/2),
      child: GestureDetector(
        // onTap: () async{
        //   final chatroom = await controller.getOrCreateChatRoom(currentUserId: currentUserId, targetUserId: sellerUserId);
        //   final sellerUser = await controller.getUserModel(userId: sellerUserId);
        //   final currentUser = await controller.getUserModel(userId: currentUserId);
        //   Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatRoomScreen(targetUser: sellerUser, chatroom: chatroom, userModel: currentUser)));
        // },
        onTap: () async {
          final controller = Get.find<NewChatController>();
          final vendorUserModel = await controller.getUserModel(userId: product.productSellerId);
          final userUserModel = await controller.getUserModel(userId: userId);
          if (vendorUserModel == null || userUserModel == null) return;
          Get.to(() => NewMessagesScreen(productId: product.productId, chatId: '', userId: userId, vendorUserModel: vendorUserModel));
        },
        child: Container(
          width: double.infinity, height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 12, spreadRadius: 1, offset: const Offset(0, 4),),],
            gradient: const LinearGradient(colors: [Color(0xFF1E1E1E), Color(0xFF3A3A3A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                const Icon(Iconsax.message, color: Colors.white, size: 28),
                Flexible(child: Text("Chat with ${product.productSeller}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 1,), maxLines: 1, overflow: TextOverflow.ellipsis,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
