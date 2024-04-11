import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskez/core/app_color.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: CustomPaint(
            size: Size(Get.width, Get.width),
            painter: RPSCustomPainter(),
          ),
        ),
        Positioned(
          top: Get.width / 1.4,
          left: Get.width / 4,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HexColor.fromHex("#84c16c"),
            ),
            width: 50,
            height: 50,
            child: const Icon(
              Icons.done,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9876401 / 3, size.height * 0.4538284 / 3);
    path_0.lineTo(size.width * 0.7837781 / 3, size.height * 0.1007778 / 3);
    path_0.cubicTo(
        size.width * 0.7672692 / 3,
        size.height * 0.07220303 / 3,
        size.width * 0.7368166 / 3,
        size.height * 0.05462586 / 3,
        size.width * 0.7038486 / 3,
        size.height * 0.05462586 / 3);
    path_0.lineTo(size.width * 0.2961432 / 3, size.height * 0.05462586 / 3);
    path_0.cubicTo(
        size.width * 0.2631772 / 3,
        size.height * 0.05462586 / 3,
        size.width * 0.2327329 / 3,
        size.height * 0.07220303 / 3,
        size.width * 0.2162116 / 3,
        size.height * 0.1007778 / 3);
    path_0.lineTo(size.width * 0.01236199 / 3, size.height * 0.4538284 / 3);
    path_0.cubicTo(
        size.width * -0.004119972 / 3,
        size.height * 0.4824011 / 3,
        size.width * -0.004119972 / 3,
        size.height * 0.5175637 / 3,
        size.width * 0.01236199 / 3,
        size.height * 0.5461406 / 3);
    path_0.lineTo(size.width * 0.2162116 / 3, size.height * 0.8992222 / 3);
    path_0.cubicTo(
        size.width * 0.2327329 / 3,
        size.height * 0.9277970 / 3,
        size.width * 0.2631772 / 3,
        size.height * 0.9453762 / 3,
        size.width * 0.2961432 / 3,
        size.height * 0.9453762 / 3);
    path_0.lineTo(size.width * 0.7038465 / 3, size.height * 0.9453762 / 3);
    path_0.cubicTo(
        size.width * 0.7368166 / 3,
        size.height * 0.9453762 / 3,
        size.width * 0.7672692 / 3,
        size.height * 0.9277970 / 3,
        size.width * 0.7837760 / 3,
        size.height * 0.8992222 / 3);
    path_0.lineTo(size.width * 0.9876401 / 3, size.height * 0.5461406 / 3);
    path_0.cubicTo(
        size.width * 1.004120 / 3,
        size.height * 0.5175637 / 3,
        size.width * 1.004120 / 3,
        size.height * 0.4824011 / 3,
        size.width * 0.9876401 / 3,
        size.height * 0.4538284 / 3);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = HexColor.fromHex("#246bfe").withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
