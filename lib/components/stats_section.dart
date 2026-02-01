import 'package:flutter/material.dart';
import 'dart:math' as math;

class StatsSection extends StatefulWidget {
  const StatsSection({super.key});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  double _currentValue = 0;
  final List<_StatData> _stats = [
    _StatData(value: 50000, label: 'Active Traders', suffix: '+'),
    _StatData(value: 2500000000, label: 'Trading Volume', suffix: 'B+'),
    _StatData(value: 150, label: 'Countries', suffix: '+'),
    _StatData(value: 99.9, label: 'Uptime', suffix: '%'),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        _startAnimation();
      }
    });
  }

  void _startAnimation() {
    final duration = const Duration(milliseconds: 2000);
    final startTime = DateTime.now().millisecondsSinceEpoch;

    void animate() {
      final now = DateTime.now().millisecondsSinceEpoch;
      double progress = (now - startTime) / duration.inMilliseconds;
      if (progress > 1) progress = 1;

      final easeOutQuart = 1 - math.pow(1 - progress, 4);
      setState(() {
        _currentValue = _stats[0].value * easeOutQuart;
      });

      if (progress < 1) {
        Future.microtask(() => animate());
      }
    }

    animate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _stats.map((stat) {
          return _StatCard(
            stat: stat,
            currentValue: _currentValue,
          );
        }).toList(),
      ),
    );
  }
}

class _StatData {
  final double value;
  final String label;
  final String suffix;

  const _StatData({
    required this.value,
    required this.label,
    required this.suffix,
  });
}

class _StatCard extends StatelessWidget {
  final _StatData stat;
  final double currentValue;

  const _StatCard({
    required this.stat,
    required this.currentValue,
  });

  String _formatValue(double value) {
    if (value >= 10000) {
      return '${(value / 10000).toStringAsFixed(1)}万';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return value.toStringAsFixed(stat.suffix == '%' ? 1 : 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Animated ring
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CustomPaint(
                          painter: _AnimatedRingPainter(
                            progress: 0.7,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          ),
                        ),
                      ),
                      // Content
                      Text(
                        '${_formatValue(currentValue)}${stat.suffix}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  stat.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 3,
                  width: 0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedRingPainter extends CustomPainter {
  final double progress;
  final Color color;

  const _AnimatedRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.45;
    final strokeWidth = 2.0;
    final startAngle = -math.pi / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Draw the ring
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * math.pi * 0.5, // 50% progress
      false,
      paint,
    );

    // Draw animated progress
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * math.pi * progress * 0.5,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_AnimatedRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
