import 'package:rentndeal/constants/consts.dart';

class CurveWidget extends StatelessWidget {
  const CurveWidget({super.key, this.child});

  final Widget? child;
  
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdges(),
      child: child
    );
  }
}