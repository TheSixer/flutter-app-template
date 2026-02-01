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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'Inter',
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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: const [
                Header(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
