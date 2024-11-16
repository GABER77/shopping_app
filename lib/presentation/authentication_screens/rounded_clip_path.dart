import 'package:flutter/material.dart';

class RoundedClipPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    double w = size.width;
    double h = size.height;

    path.lineTo(0, h * 0.85);
    path.quadraticBezierTo(
      w / 2,
      h + (h * 0.15),
      w,
      h * 0.85,
    );
    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}