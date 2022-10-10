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
                  color: showGradient ? null : primaryDarkColor1,
                  gradient: showGradient ? mainGradient(context) : null
                ),
                child: CustomPaint(
                  painter: BackgroundPaint(),
                ),
              ),
          ),
          Positioned(
            child: child,
          ),
        ]
      ),
    );
  }
}

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = primaryDark;
    final path = Path();
    final path1 = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(0, size.height * .4);
    path.close();

    path1.moveTo(size.width, 0);
    path1.lineTo(size.width * 0.8, 0);
    path1.lineTo(size.width * .2, size.height);
    path1.lineTo(size.width, size.height);
    path1.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
