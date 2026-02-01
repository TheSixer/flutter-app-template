import 'package:flutter/material.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final features = const [
      {
        'icon': Icons.extension_rounded,
        'title': 'Visual Strategy Builder',
        'description': 'Drag-and-drop interface to build complex strategies without coding',
      },
      {
        'icon': Icons.bar_chart_rounded,
        'title': 'Advanced Backtesting',
        'description': 'Test strategies with historical data and realistic market conditions',
      },
      {
        'icon': Icons.bolt_rounded,
        'title': 'Real-Time Execution',
        'description:': 'Deploy strategies with institutional-grade execution speed',
      },
      {
        'icon': Icons.shield_rounded,
        'title': 'Risk Management',
        'description': 'Built-in risk controls and position sizing algorithms',
      },
      {
        'icon': Icons.memory_rounded,
        'title': 'AI Optimization',
        'description': 'Machine learning powered parameter optimization',
      },
      {
        'icon': Icons.public_rounded,
        'title': 'Multi-Market Support',
        'description': 'Trade across forex, crypto, stocks, and commodities',
      },
    ];

    // 移动端：2列；平板：3列；桌面：6列
    final crossAxisCount = context.breakpoint >= 1200 ? 3 : (context.breakpoint >= 768 ? 2 : 1);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const Center(
            child: Column(
              children: [
                Text(
                  'Why Choose Our Platform',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Everything you need to build, test, and deploy professional trading strategies',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          SizedBox(
            height: 600,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 32,
                mainAxisSpacing: 32,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                return _FeatureCard(
                  feature: features[index],
                  index: index,
                );
              },
            ),
          ),
          const SizedBox(height: 64),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Get Started Free'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {},
                child: const Text('View Documentation'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final Map<String, dynamic> feature;
  final int index;

  const _FeatureCard({required this.feature, required this.index});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    widget.feature['icon'] as IconData,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.feature['title'] as String,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.feature['description'] as String,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

extension BuildContextExtension on BuildContext {
  double get breakpoint {
    final width = MediaQuery.of(this).size.width;
    if (width < 768) return 1; // Mobile
    if (width < 1200) return 2; // Tablet
    return 3; // Desktop
  }
}
