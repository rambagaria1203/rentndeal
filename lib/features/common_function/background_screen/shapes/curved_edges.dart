import 'package:rentndeal/constants/consts.dart';

class CustomCurvedEdges extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    // First Curve
    var firstStartPoint = Offset(0, size.height - 20);
    var firstEndPoint = Offset(30, size.height - 20);
    path.quadraticBezierTo(firstStartPoint.dx, firstStartPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    // Straight Line
    var secondStartPoint = Offset(30, size.height - 20);
    var secondEndPoint = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondStartPoint.dx, secondStartPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    // Third Curve
    var thirdStartPoint = Offset(size.width, size.height - 20);
    var thirdEndPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdStartPoint.dx, thirdStartPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}