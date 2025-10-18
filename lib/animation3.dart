import 'package:flutter/material.dart';
import 'dart:math';


class LungsAnimationScreen extends StatefulWidget {
  const LungsAnimationScreen({super.key});

  @override
  State<LungsAnimationScreen> createState() => _LungsAnimationScreenState();
}

class _LungsAnimationScreenState extends State<LungsAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _breathing;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _breathing = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _breathing,
          builder: (context, child) {
            return Transform.scale(
              scale: _breathing.value,
              child: CustomPaint(
                size: const Size(300, 300),
                painter: LungsPainter(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LungsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyanAccent
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final lungWidth = size.width / 4;
    final lungHeight = size.height / 2;

    // Left lung
    final leftLung = Path()
      ..moveTo(centerX, centerY)
      ..cubicTo(centerX - lungWidth, centerY - lungHeight / 2,
          centerX - lungWidth, centerY + lungHeight / 2, centerX, centerY + lungHeight)
      ..close();

    // Right lung
    final rightLung = Path()
      ..moveTo(centerX, centerY)
      ..cubicTo(centerX + lungWidth, centerY - lungHeight / 2,
          centerX + lungWidth, centerY + lungHeight / 2, centerX, centerY + lungHeight)
      ..close();

    canvas.drawPath(leftLung, paint);
    canvas.drawPath(rightLung, paint);

    // Trachea (breathing pipe)
    final tracheaPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(centerX, centerY - lungHeight / 1.5),
      Offset(centerX, centerY - 20),
      tracheaPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}