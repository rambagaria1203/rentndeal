import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/chat/screen/messages_screen.dart';
import 'package:rentndeal/features/vendor_page/screen/upload_product.dart';



class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = HHelperFunctions.isDarkMode(context);
    
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: dark ? CColors.black: CColors.white,
          indicatorColor: dark? CColors.white.withOpacity(0.1): CColors.black.withOpacity(0.1),
        
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.category), label: "Categories"),
            NavigationDestination(icon: CustomCenterIcon(), label: ""),
            NavigationDestination(icon: Icon(Icons.chat), label: "Chat"),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
            
          ],
        ),
      ),
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const HomeS(), const CategoryS(), const UploadProductScreen(), const MessagesScreen(),const SettingS(),];
}


// Center Navigation Button
class CustomCenterIcon extends StatelessWidget {
  const CustomCenterIcon({super.key});

  @override
  Widget build (BuildContext context){
    return Container(
      padding: const EdgeInsets.all(CSizes.defaultSpace / 1.2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [CColors.blueColor, CColors.buttonPrimary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4, spreadRadius: 0.5, offset: Offset(0, 2))],
      ),
      child: const Icon(Icons.add, size: 32, color: Colors.white),
    );
  }
}