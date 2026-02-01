import 'package:flutter/material.dart';
import 'components/header.dart';
import 'components/hero_section.dart';
import 'components/stats_section.dart';
import 'components/features_section.dart';
import 'components/strategy_marketplace.dart';
import 'components/footer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeepWave Quant',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Header(),
            SizedBox(height: 0),
            HeroSection(),
            SizedBox(height: 0),
            StatsSection(),
            SizedBox(height: 0),
            FeaturesSection(),
            SizedBox(height: 0),
            StrategyMarketplace(),
            SizedBox(height: 0),
            Footer(),
          ],
        ),
      ),
    );
  }
}
