import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isVisible = true;
  double _lastScrollY = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  void _onScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final currentScrollY = notification.metrics.pixels;

      if (currentScrollY > 80) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
          });
          _controller.reverse();
        }
      } else {
        if (!_isVisible) {
          setState(() {
            _isVisible = true;
          });
          _controller.forward();
        }
      }

      _lastScrollY = currentScrollY;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final offset = _controller.value * -100.0;
        return Transform.translate(
          offset: Offset(0, offset),
          child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: _controller.value > 0.1
                  ? Theme.of(context).colorScheme.surface.withOpacity(0.95)
                  : Colors.transparent,
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DeepWave Quant',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Row(
                      children: [
                        _NavItem(icon: Icons.bar_chart, label: 'Strategy Market'),
                        SizedBox(width: 24),
                        _NavItem(icon: Icons.hexagon, label: 'Strategy Builder'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
        ),
      ],
    );
  }
}
