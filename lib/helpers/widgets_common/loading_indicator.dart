import 'package:rentndeal/constants/consts.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(CColors.blueColor),
  );
}