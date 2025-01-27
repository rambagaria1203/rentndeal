import 'package:rentndeal/constants/consts.dart';


Widget exitDialog(context) {
  
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to signout?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
              color: CColors.blueColor,
              onPress: () async{
                //SystemNavigator.pop();
                  Navigator.pop(context);
                  // await auth.signOut();
                  //await Get.put(AuthController()).signInWithGoogle(context);
                 // await Get.put(AuthController()).signOutMethod(context);
                  //Get.offAll(() =>const LoginScreen());

              },
              textColor: whiteColor,
              title: "Yes"
            ),
            ourButton(
              color: CColors.blueColor,
              onPress: () {
                Navigator.pop(context);
              },
              textColor: whiteColor,
              title: "No"
            ),
          ],
        )
      ],
    ).box.color(lightGrey).roundedSM.padding(const EdgeInsets.all(12)).make(),
  );
}