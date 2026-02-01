import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          ),
        ),
      ),
      child: const Center(
        child: Column(
          children: [
            _BrandInfo(),
            SizedBox(height: 32),
            _QuickLinks(),
            SizedBox(height: 16),
            _LegalLinks(),
            SizedBox(height: 32),
            _Copyright(),
          ],
        ),
      ),
    );
  }
}

class _BrandInfo extends StatelessWidget {
  const _BrandInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'DeepWave Quant',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Professional Quantitative Trading Platform',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

class _QuickLinks extends StatelessWidget {
  const _QuickLinks();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Quick Links',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        _LinkItem(label: 'Strategy Market', icon: Icons.bar_chart),
        SizedBox(height: 8),
        _LinkItem(label: 'Strategy Builder', icon: Icons.hexagon),
        SizedBox(height: 8),
        _LinkItem(label: 'Backtest', icon: Icons.analytics_rounded),
      ],
    );
  }
}

class _LinkItem extends StatelessWidget {
  final String label;
  final IconData icon;

  const _LinkItem({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
        ),
      ],
    );
  }
}

class _LegalLinks extends StatelessWidget {
  const _LegalLinks();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Legal',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        _LinkItem(label: 'Terms of Service', icon: Icons.description),
        SizedBox(height: 8),
        _LinkItem(label: 'Privacy Policy', icon: Icons.privacy_tip),
      ],
    );
  }
}

class _Copyright extends StatelessWidget {
  const _Copyright();

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Text(
      '© $currentYear DeepWave Quant. All rights reserved.',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
    );
  }
}
