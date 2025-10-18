import 'package:flutter/material.dart';
import 'dart:math';

import 'package:makkahjourney/animation2.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _phase = "Inhale";
  int _remainingSeconds = 180; // 3 minutes timer
  double _ballProgress = 0.0; // 0 → 1 over total duration

  @override
  void initState() {
    super.initState();

    // 10s = Inhale(4s) + Hold(2s) + Exhale(4s)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        final t = _controller.value;
        if (t < 0.4) {
          _phase = "Inhale";
        } else if (t < 0.6) {
          _phase = "Hold";
        } else {
          _phase = "Exhale";
        }
        setState(() {});
      });

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    );

    _controller.repeat();

    Future.delayed(const Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer() {
    if (_remainingSeconds > 0) {
      setState(() {
        _remainingSeconds--;
        // Update ball progress from 0 → 1
        _ballProgress = (180 - _remainingSeconds) / 180;
      });
      Future.delayed(const Duration(seconds: 1), _updateTimer);
    } else {
      // Navigate to next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BreathingAnimationScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Custom easing: slow up (inhale), hold at bottom, smooth down
  double _customEase(double t) {
    if (t < 0.4) return Curves.easeOutCubic.transform(t / 0.4); // inhale
    if (t < 0.6) return 1.0; // hold
    return Curves.easeInOutCubic.transform(1 - ((t - 0.6) / 0.4)); // exhale
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF001F3F),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            final t = _animation.value;
            final easedT = _customEase(t);
            final scale = 1 + (easedT * 0.4);

            return Stack(
              alignment: Alignment.center,
              children: [
                // Background gradient
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.0,
                        colors: [
                          Colors.blueAccent.withOpacity(0.15),
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                ),

                // Expanding glow
                Container(
                  width: 250 * scale,
                  height: 250 * scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent.withOpacity(0.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        blurRadius: 50,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                ),

                // Content
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Serenity",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Timer
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _formatTime(_remainingSeconds),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Phase Text
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        _phase,
                        key: ValueKey(_phase),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Wave animation
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, _) {
                        final waveWidth = width * 0.8;
                        final waveHeight = 150.0;

                        // Ball moves forward along the wave
                        final x = waveWidth * _ballProgress;

                        final y = sin((x / waveWidth * 2 * pi) +
                                (t * 2 * pi)) *
                            waveHeight /
                            2.5;

                        return SizedBox(
                          width: waveWidth,
                          height: waveHeight + 100,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: Size(waveWidth, waveHeight),
                                painter: WavePainter(t),
                              ),
                              Positioned(
                                left: x - 10,
                                top: (waveHeight / 2 - y - 5) - 10,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.easeInOut,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.yellowAccent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.yellowAccent
                                                .withOpacity(0.6),
                                            blurRadius: 25,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // Music note
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.music_note,
                            color: Colors.white.withOpacity(0.7)),
                        const SizedBox(width: 8),
                        Text(
                          "Relaxing Music On",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}

class WavePainter extends CustomPainter {
  final double t;
  WavePainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path = Path();
    final midY = size.height / 2 - 20;

    for (double x = 0; x <= size.width; x++) {
      final y = sin((x / size.width * 2 * pi) + (t * 2 * pi)) *
          size.height /
          2.5;

      if (x == 0) {
        path.moveTo(x, midY - y);
      } else {
        path.lineTo(x, midY - y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) => true;
}
