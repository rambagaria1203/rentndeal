import 'package:rentndeal/constants/consts.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget{

  const CustomTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? CColors.black : CColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: CColors.primary,
        labelColor: dark ? CColors.white : CColors.primary,
        unselectedLabelColor: CColors.darkgrey,
        ),
    );
  }
  
@override
Size get preferredSize => Size.fromHeight(HDeviceUtils.getAppBarHeight());
}

