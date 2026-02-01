import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// TradingChart - 动态K线图背景动画
class TradingChart extends StatefulWidget {
  const TradingChart({super.key});

  @override
  State<TradingChart> createState() => _TradingChartState();
}

class _TradingChartState extends State<TradingChart> {
  late final _candleWidth = 12.0;
  late final _candleGap = 4.0;
  late final _totalCandleWidth = _candleWidth + _candleGap;
  late final _chartHeight;
  late final _chartTop;
  late final _chartBottom;
  late List<_Candle> candles;
  late double _offset;
  late final _scrollSpeed = 0.8;

  @override
  void initState() {
    super.initState();
    _chartHeight = MediaQuery.of(context).size.height * 0.6;
    _chartTop = MediaQuery.of(context).size.height * 0.2;
    _chartBottom = _chartTop + _chartHeight;

    // 初始化K线数据
    candles = [];
    var lastClose = _chartTop + _chartHeight / 2;

    for (int i = 0; i < 20; i++) {
      candles.add(_generateCandle(lastClose));
      lastClose = candles.last.close;
    }

    _offset = 0.0;
  }

  _Candle _generateCandle(double lastClose) {
    final volatility = _chartHeight * 0.15;
    final open = lastClose;
    final change = (math.Random().nextDouble() - 0.5) * volatility;
    final close = open + change;

    final highLowRange = math.abs(change) + math.Random().nextDouble() * volatility * 0.5;
    final high = math.max(open, close) + math.Random().nextDouble() * highLowRange * 0.5;
    final low = math.min(open, close) - math.Random().nextDouble() * highLowRange * 0.5;

    return _Candle(
      open: math.max(_chartTop, math.min(_chartBottom, open)),
      close: math.max(_chartTop, math.min(_chartBottom, close)),
      high: math.max(_chartTop, math.min(_chartBottom, high)),
      low: math.max(_chartTop, math.min(_chartBottom, low)),
    );
  }

  void _scrollCandles() {
    if (!mounted) return;

    setState(() {
      _offset += _scrollSpeed;

      // 当滚动超过一根K线宽度时，移除第一根，添加新的一根
      if (_offset >= _totalCandleWidth) {
        _offset -= _totalCandleWidth;
        candles.removeAt(0);

        // 添加新K线
        candles.add(_generateCandle(candles.last.close));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TradingChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scrollCandles();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _TradingChartPainter(
        candles: candles,
        offset: _offset,
        candleWidth: _candleWidth,
        candleGap: _candleGap,
        totalCandleWidth: _totalCandleWidth,
        chartTop: _chartTop,
        chartBottom: _chartBottom,
      ),
    );
  }
}

class _Candle {
  final double open;
  final double close;
  final double high;
  final double low;

  const _Candle({
    required this.open,
    required this.close,
    required this.high,
    required this.low,
  });
}

class _TradingChartPainter extends CustomPainter {
  final List<_Candle> candles;
  final double offset;
  final double candleWidth;
  final double candleGap;
  final double totalCandleWidth;
  final double chartTop;
  final double chartBottom;

  _TradingChartPainter({
    required this.candles,
    required this.offset,
    required this.candleWidth,
    required this.candleGap,
    required this.totalCandleWidth,
    required this.chartTop,
    required this.chartBottom,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final bgColor = Theme.of(context).colorScheme.surface;

    for (int i = 0; i < candles.length; i++) {
      final x = i * totalCandleWidth - offset;

      // 只绘制在屏幕内的K线
      if (x > -totalCandleWidth && x < size.width + totalCandleWidth) {
        _drawCandle(canvas, candles[i], x, candleWidth, primaryColor, bgColor);
      }
    }
  }

  void _drawCandle(Canvas canvas, _Candle candle, double x, double candleWidth, Color primaryColor, Color bgColor) {
    final isGreen = candle.close > candle.open;
    final color = isGreen
      ? Colors.green.withOpacity(0.3)
      : Colors.red.withOpacity(0.3);

    // 获取背景色
    final canvasBgColor = Theme.of(context).colorScheme.surface;

    final bodyTop = math.min(candle.open, candle.close);
    final bodyBottom = math.max(candle.open, candle.close);
    final bodyHeight = math.max(3, bodyBottom - bodyTop);
    final centerX = x + candleWidth / 2;

    // 1. 先绘制完整的影线（从最高点到最低点）
    final shadowPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(centerX, candle.high),
      Offset(centerX, candle.low),
      shadowPaint,
    );

    // 2. 填充实体区域，遮盖中间的影线
    final fillPaint = Paint()
      ..color = canvasBgColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(x + 1, bodyTop, x + candleWidth - 1, bodyBottom),
      fillPaint,
    );

    // 3. 绘制实体边框
    final borderPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(x, bodyTop),
      Offset(x + candleWidth, bodyBottom),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(_TradingChartPainter oldDelegate) {
    return oldDelegate.candles != candles ||
           oldDelegate.offset != offset;
  }
}
