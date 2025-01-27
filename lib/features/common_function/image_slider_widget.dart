import 'package:carousel_slider/carousel_slider.dart';
import 'package:rentndeal/constants/consts.dart';

class ImageSliderWidget extends StatelessWidget {
  const ImageSliderWidget({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeeController());

    return Column(
      children:[
        CarouselSlider(
          items: images.map((url) => RoundedProductImages(imageUrl: url)).toList(),
          options: CarouselOptions(viewportFraction: 1, onPageChanged: (index,_)=> controller.updatePageIndicator(index)),
        ),
        const SizedBox(height: CSizes.spaceBtwItems),
        Obx(
          ()=>
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < images.length; i++) CircularContainer(width: 20, height: 4, margin: const EdgeInsets.only(right: 10), backgroundColor: controller.carousalCurrentIndex.value == i ? CColors.primary : CColors.grey),
              ],
            ),
        ),
    
      ]
    );
  }
}