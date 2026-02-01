import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../common/glowing_orbs.dart';
import '../../common/financial_grid.dart';
import '../../common/trading_chart.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景
        Positioned.fill(
          child: Column(
            children: [
              Expanded(
                child: const FinancialGrid(),
              ),
              Expanded(
                child: const GlowingOrbs(),
              ),
              Expanded(
                child: const TradingChart(),
              ),
            ],
          ),
        ),
        // 内容
        Positioned.fill(
          child: Container(
            padding: const EdgeInsets.only(top: 140, bottom: 80),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surfaceContainerLowest,
                ],
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _TrustBadge(),
                  SizedBox(height: 24),
                  _MainHeading(),
                  SizedBox(height: 16),
                  _Description(),
                  SizedBox(height: 48),
                  _CTAButtons(),
                  SizedBox(height: 48),
                  _SocialProof(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TrustBadge extends StatelessWidget {
  const _TrustBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shield_rounded, size: 16, color: Colors.blue),
          SizedBox(width: 8),
          Text('50,000+ Traders'),
        ],
      ),
    );
  }
}

class _MainHeading extends StatelessWidget {
  const _MainHeading();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Professional Quantitative',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.blue,
              Colors.blueAccent,
            ],
          ).createShader(bounds),
          child: const Text(
            'Strategy Creation Platform',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Build, backtest, and deploy algorithmic trading strategies with institutional-grade tools. No coding required.',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _CTAButtons extends StatelessWidget {
  const _CTAButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.bolt_rounded),
          label: const Text('Start Building'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            elevation: 12,
          ),
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.bar_chart_rounded),
          label: const Text('Explore Strategies'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
      ],
    );
  }
}

class _SocialProof extends StatelessWidget {
  const _SocialProof();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: const [
            Icon(Icons.star_rounded, size: 20, color: Colors.yellow),
            SizedBox(width: 8),
            Text(
              '4.9/5',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              ' from 2,000+ reviews',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(width: 16),
        const Text(
          r'$2.5B+ trading volume',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(width: 16),
        const Text(
          '150+ countries',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
