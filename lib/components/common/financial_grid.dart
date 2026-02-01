import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// FinancialGrid - 财务网格背景动画
class FinancialGrid extends StatefulWidget {
  const FinancialGrid({super.key});

  @override
  State<FinancialGrid> createState() => _FinancialGridState();
}

class _FinancialGridState extends State<FinancialGrid> {
  late int animationFrame;
  late final _gridSize = 60.0;

  @override
  void initState() {
    super.initState();
    animationFrame = 0;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _FinancialGridPainter(
        animationFrame: animationFrame,
        gridSize: _gridSize,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _animate() {
    if (!mounted) return;

    setState(() {
      animationFrame++;
    });

    Future.delayed(const Duration(milliseconds: 16), _animate);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animate();
  }
}

class _FinancialGridPainter extends CustomPainter {
  final int animationFrame;
  final double gridSize;

  _FinancialGridPainter({
    required this.animationFrame,
    required this.gridSize,
  });

  Color? _getPrimaryColor(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return primaryColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final primaryColor = _getPrimaryColor(context) ?? Colors.blue;
    final pulseSpeed = 0.02;
    final primaryR = (primaryColor.value >> 16) & 0xFF;
    final primaryG = (primaryColor.value >> 8) & 0xFF;
    final primaryB = primaryColor.value & 0xFF;

    // 绘制垂直线
    for (double x = 0; x < size.width; x += gridSize) {
      final pulse = math.sin(animationFrame * pulseSpeed + x * 0.01) * 0.05 + 0.95;
      final alpha = (pulse * 0.3 * 255).toInt();
      final paint = Paint()
        ..color = Color.fromRGBO(primaryR, primaryG, primaryB, alpha / 255)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // 绘制水平线
    for (double y = 0; y < size.height; y += gridSize) {
      final pulse = math.sin(animationFrame * pulseSpeed + y * 0.01) * 0.05 + 0.95;
      final alpha = (pulse * 0.3 * 255).toInt();
      final paint = Paint()
        ..color = Color.fromRGBO(primaryR, primaryG, primaryB, alpha / 255)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // 绘制交叉点高亮
    final dotPaint = Paint()
      ..color = Color.fromRGBO(primaryR, primaryG, primaryB, 102); // 0.4 * 255

    for (double x = 0; x < size.width; x += gridSize) {
      for (double y = 0; y < size.height; y += gridSize) {
        final pulse = math.sin(animationFrame * pulseSpeed + x * 0.01 + y * 0.01) * 0.5 + 0.5;
        final alpha = (pulse * 0.2 * 255).toInt();
        dotPaint.color = Color.fromRGBO(primaryR, primaryG, primaryB, alpha);

        canvas.drawCircle(
          Offset(x, y),
          2,
          dotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_FinancialGridPainter oldDelegate) {
    return oldDelegate.animationFrame != animationFrame;
  }
}
