import 'package:flutter/material.dart';

class CustomBottomBarClipper extends CustomClipper<Path> {
  final double startPoint;
  final double cutWidth;

  CustomBottomBarClipper({
    required this.startPoint,
    required this.cutWidth,
  });

  @override
  getClip(Size size) {
    var path = Path();
    var widthParcel = cutWidth / 14;
    var cutHeight = 50;
    var heightParcel = cutHeight / 6;

    path.lineTo(startPoint, 0.0);

    var p1 = Offset(startPoint + 3 * widthParcel, heightParcel);
    var p2 = Offset(p1.dx + widthParcel, p1.dy + 2 * heightParcel);

    var p3 = Offset(p2.dx + widthParcel, p2.dy + 2 * heightParcel);
    var p4 = Offset(p3.dx + 2 * widthParcel, (p3.dy + heightParcel) / 1.25);

    var p5 = Offset(p4.dx + 2 * widthParcel, (p4.dy - heightParcel) * 1.25);
    var p6 = Offset(p5.dx + widthParcel, p5.dy - 2 * heightParcel);

    var p7 = Offset(p6.dx + widthParcel, p6.dy - 2 * heightParcel);
    var p8 = Offset(p7.dx + 3 * widthParcel, p7.dy - heightParcel);

    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    path.quadraticBezierTo(p3.dx, p3.dy, p4.dx, p4.dy);
    path.quadraticBezierTo(p5.dx, p5.dy, p6.dx, p6.dy);
    path.quadraticBezierTo(p7.dx, p7.dy, p8.dx, p8.dy);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
