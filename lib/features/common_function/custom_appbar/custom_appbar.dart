import 'package:rentndeal/constants/consts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.backgroundColor,
    this.showBackArrow = false
    });

    final Widget? title;
    final Color? backgroundColor;
    final bool showBackArrow;
    final IconData? leadingIcon;
    final List<Widget>? actions;
    final VoidCallback? leadingOnPressed;


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      automaticallyImplyLeading: false,
      leading: showBackArrow 
        ? IconButton(onPressed: ()=> Get.back(), icon: const Icon(Icons.arrow_back))
        : leadingIcon !=  null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)) : null,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CSizes.md),
        child: title,
      ),
      actions: actions,
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(HDeviceUtils.getAppBarHeight());
}