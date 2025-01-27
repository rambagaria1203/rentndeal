import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/vendor_page/screen/upload_product.dart';


class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: Text('My Products', style: Theme.of(context).textTheme.headlineMedium),
        ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('No Products Available', style: Theme.of(context).textTheme.bodyLarge,))
        ]
      ),

      // Floating Button
      floatingActionButton: FloatingActionButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const UploadProductScreen();
        }));}, backgroundColor: CColors.primary, child: const Icon(Icons.add, color: whiteColor, size: 28,),),
    );
  }
}