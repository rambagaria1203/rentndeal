import 'package:rentndeal/constants/consts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatelessWidget {

  final dynamic data;

  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {

    var _controller = PageController();

    var product = data.data() as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: lightGrey,
        title: boldText(text: "${product['product_name']}", color: CColors.blueColor, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 350,
              child:PageView.builder(
                controller: _controller,
                //autoPlay: true,
                //height: 350,
                itemCount: data['Images'].length, 
                //aspectRatio: 16/9,
                //viewportFraction: 1.0,
                itemBuilder: (context, index){
                return Image.network(
                  data['Images'][index], 
                  width:double.infinity, 
                  fit: BoxFit.cover, 
                  errorBuilder: (context, error, stackTrace) =>const Icon(Icons.error));
              }
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller:_controller, 
                count:product['Images'].length,
                effect:const JumpingDotEffect(
                  activeDotColor: royalblueColor,
                  dotHeight: 15,
                  dotWidth: 15,
                  spacing: 8
                  ),
                ),
            ),
              10.heightBox,

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(text: "${product['Name']}", color: darkFontGrey, size: 16.0),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: "${product['Category']}", color: fontGrey, size: 16.0),
                      20.widthBox,
                      normalText(text: "${product['Subcategory']}", color: fontGrey, size: 16.0)
                    ],
                  ),
                  10.heightBox,
                
                VxRating(
                  isSelectable: false,
                  value: 3.0,
                  onRatingUpdate: (value) {},
                  selectionColor: golden,
                  count: 5,
                  maxRating: 5,
                  size: 25,
                  ),
                10.heightBox,
                boldText(text: "${product['Rent']}/${data['Rent Period']}", color: CColors.blueColor, size: 18.0),
                10.heightBox,
                boldText(text: "${product['Price']}", color: CColors.blueColor, size: 18.0),
                

                const Divider(),
                10.heightBox,
                boldText(text: "Description", color: darkFontGrey),
                //"Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                10.heightBox,
                normalText(text: "${product['Description']}", color: darkFontGrey),

                  ],
                ),
                
              )
              
        
        ],),
      ),
    ) ;
  }
}