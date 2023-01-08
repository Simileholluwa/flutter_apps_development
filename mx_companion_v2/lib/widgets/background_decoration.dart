import 'package:flutter/material.dart';
import 'package:mx_companion_v2/config/themes/app_colors.dart';
import 'package:mx_companion_v2/config/themes/app_dark_theme.dart';

class BackgroundDecoration extends StatelessWidget {
  final Widget child;
  final bool showGradient;
  const BackgroundDecoration({Key? key, required this.child, this.showGradient = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children : [
          Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: showGradient ? null : primaryDark,
                  gradient: showGradient ? mainGradient(context) : null
                ),
                child: CustomPaint(
                  painter: BackgroundPaint(),
                ),
              ),
          ),
          Positioned.fill(
            child: SafeArea(child: child),
          ),
        ]
      ),
    );
  }
}

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = primaryDarkColor1;
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.025);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * .2,
      size.width,
      size.height * 0.025,
    );
    path.lineTo(size.width, 0);


    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
