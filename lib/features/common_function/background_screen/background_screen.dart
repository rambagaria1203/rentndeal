import 'package:rentndeal/constants/consts.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurveWidget(
      child: Container(
        color: CColors.primary,
          child: Stack(
            children: [
              Positioned(top: -150, right: -250, child: CircularContainer(backgroundColor: CColors.white.withOpacity(0.1))),
              Positioned(top: 100, right: -300, child: CircularContainer(backgroundColor: CColors.white.withOpacity(0.1))),
              child,
            ],
          ),
        ),
      );
  }
}