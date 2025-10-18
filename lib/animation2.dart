import 'package:flutter/material.dart';
import 'dart:math';

class BreathingAnimationScreen extends StatefulWidget {
  const BreathingAnimationScreen({super.key});

  @override
  State<BreathingAnimationScreen> createState() =>
      _BreathingAnimationScreenState();
}

class _BreathingAnimationScreenState extends State<BreathingAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _currentInstruction = 'Inhale';
  int _currentStep = 0; // 0: Inhale, 1: Hold, 2: Exhale
  final List<double> _durations = [4.0, 7.0, 8.0]; // seconds

  @override
  void initState() {
    super.initState();
    final totalDuration = _durations.reduce((a, b) => a + b);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (totalDuration * 1000).toInt()),
    )..addListener(_updateInstruction);

    _controller.repeat();
  }

  void _updateInstruction() {
    final double elapsed =
        _controller.value * _controller.duration!.inMilliseconds;

    if (elapsed < _durations[0] * 1000) {
      if (_currentStep != 0) {
        setState(() {
          _currentStep = 0;
          _currentInstruction = 'Inhale';
        });
      }
    } else if (elapsed < (_durations[0] + _durations[1]) * 1000) {
      if (_currentStep != 1) {
        setState(() {
          _currentStep = 1;
          _currentInstruction = 'Hold';
        });
      }
    } else {
      if (_currentStep != 2) {
        setState(() {
          _currentStep = 2;
          _currentInstruction = 'Exhale';
        });
      }
    }
  }

  double _getWaveValue() {
  final elapsed = _controller.value * _controller.duration!.inMilliseconds;
  double waveValue = 0.0;

  if (_currentStep == 0) {
    // Inhale: 0 -> 1
    waveValue = ((elapsed / (_durations[0] * 1000))).clamp(0.0, 1.0);
  } else if (_currentStep == 1) {
    // Hold: stay at max
    waveValue = 1.0;
  } else if (_currentStep == 2) {
    // Exhale: 1 -> 0
    final start = (_durations[0] + _durations[1]) * 1000;
    final end = _durations.reduce((a, b) => a + b) * 1000;
    waveValue = (1.0 - ((elapsed - start) / (end - start))).clamp(0.0, 1.0);
  }

  return waveValue;
}


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF001F3F), // Dark premium background
      appBar: AppBar(
        title: const Text(
          'Serenity',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Timer (premium style)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "03:00",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Instruction Text
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Text(
              _currentInstruction,
              key: ValueKey(_currentInstruction),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 44,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Wave animation area
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double waveValue = _getWaveValue();
                return CustomPaint(
                  size: Size(
                    MediaQuery.of(context).size.width,
                    screenHeight / 2,
                  ),
                  painter: WaveformPainter(animationValue: waveValue),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          
         
        ],
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final double animationValue;

  WaveformPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    const double circleDiameter = 8.0;
    const double circleSpacing = 4.0;

    final Gradient waveGradient = LinearGradient(
      colors: [
        Color(0xFF0096C7),
        Color(0xFF00BFFF),
        Color(0xFFB3E5FC),
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

    final Paint paint = Paint()
      ..shader = waveGradient.createShader(Rect.fromLTWH(0, 0, width, height));

    final int layers =
        ((height / (circleDiameter + circleSpacing)) * animationValue).ceil();

    for (double x = 0; x < width; x += circleDiameter + circleSpacing) {
      for (int i = 0; i < layers; i++) {
        double y = height - (i + 1) * (circleDiameter + circleSpacing);
        canvas.drawOval(
          Rect.fromLTWH(x, y, circleDiameter, circleDiameter),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
