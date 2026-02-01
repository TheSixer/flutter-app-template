import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// GlowingOrbs - 背景发光光球动画
class GlowingOrbs extends StatefulWidget {
  const GlowingOrbs({super.key});

  @override
  State<GlowingOrbs> createState() => _GlowingOrbsState();
}

class _GlowingOrbsState extends State<GlowingOrbs> {
  late List<_Orb> orbs;
  late final _paint = Paint()
    ..style = PaintingStyle.fill;

  @override
  void initState() {
    super.initState();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    orbs = List.generate(
      6,
      (i) => _Orb(
        x: math.Random().nextDouble() * width,
        y: math.Random().nextDouble() * height,
        radius: math.Random().nextDouble() * 120 + 80,
        vx: (math.Random().nextDouble() - 0.5) * 0.2,
        vy: (math.Random().nextDouble() - 0.5) * 0.2,
        pulsePhase: math.Random().nextDouble() * math.pi * 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _GlowingOrbsPainter(
        orbs: orbs,
        pulsePhase: orbs.map((e) => e.pulsePhase).toList(),
      ),
    );
  }
}

class _Orb {
  final double x;
  final double y;
  final double radius;
  final double vx;
  final double vy;
  final double pulsePhase;

  const _Orb({
    required this.x,
    required this.y,
    required this.radius,
    required this.vx,
    required this.vy,
    required this.pulsePhase,
  });
}

class _GlowingOrbsPainter extends CustomPainter {
  final List<_Orb> orbs;
  final List<double> pulsePhase;

  _GlowingOrbsPainter({
    required this.orbs,
    required this.pulsePhase,
  });

  Color? _getPrimaryColor(BuildContext context) {
    // 获取primary颜色 (从主题)
    final primaryColor = Theme.of(context).colorScheme.primary;
    return primaryColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final primaryColor = _getPrimaryColor(context) ?? Colors.blue;

    orbs.forEach((orb) {
      // 更新位置
      orb.x += orb.vx;
      orb.y += orb.vy;

      // 边界反弹
      if (orb.x < 0 || orb.x > size.width) orb.vx *= -1;
      if (orb.y < 0 || orb.y > size.height) orb.vy *= -1;

      // 保持在边界内
      orb.x = orb.x.clamp(0.0, size.width);
      orb.y = orb.y.clamp(0.0, size.height);

      // 脉冲效果
      orb.pulsePhase += 0.015;
      final pulse = math.sin(orb.pulsePhase) * 0.2 + 0.8;

      // 解析颜色并创建渐变
      final hexColor = '#' + primaryColor.value.toRadixString(16).substring(2).padLeft(6, '0');
      final r = int.parse(hexColor.substring(0, 2), radix: 16);
      final g = int.parse(hexColor.substring(2, 4), radix: 16);
      final b = int.parse(hexColor.substring(4, 6), radix: 16);

      final gradient = ui.Gradient.radial(
        Offset(orb.x, orb.y),
        0.0,
        Offset(orb.x, orb.y),
        orb.radius * pulse,
        [
          Color.fromARGB((0.3 * 255).toInt(), r, g, b),
          Color.fromARGB((0.15 * 255).toInt(), r, g, b),
          Color.fromARGB((0.05 * 255).toInt(), r, g, b),
          Colors.transparent,
        ],
      );

      _paint.shader = gradient;
      canvas.drawCircle(Offset(orb.x, orb.y), orb.radius * pulse, _paint);
    });
  }

  @override
  bool shouldRepaint(_GlowingOrbsPainter oldDelegate) {
    return oldDelegate.pulsePhase != pulsePhase;
  }
}
