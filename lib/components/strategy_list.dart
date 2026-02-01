import 'package:flutter/material.dart';

class StrategyList extends StatefulWidget {
  final String searchTerm;
  final String category;

  const StrategyList({
    super.key,
    required this.searchTerm,
    required this.category,
  });

  @override
  State<StrategyList> createState() => _StrategyListState();
}

class _StrategyListState extends State<StrategyList> {
  final List<_Strategy> _strategies = [];
  bool _isLoading = true;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    // Simulate API loading
    Future.delayed(const Duration(milliseconds: 500), () {
      _generateStrategies();
    });
  }

  void _generateStrategies() {
    final categoryMap = {
      'forex': 'Forex',
      'crypto': 'Crypto',
      'stocks': 'Stocks',
      'commodities': 'Commodities',
      'futures': 'Futures',
    };

    final filteredStrategies = List.generate(12, (index) {
      final categoryKeys = categoryMap.keys.toList();
      final categoryKey = categoryKeys[index % categoryKeys.length];

      return _Strategy(
        id: index,
        name: 'Strategy ${index + 1}',
        description: 'Advanced trading strategy for ${categoryMap[categoryKey]} market',
        author: 'Trader${index + 1}',
        price: 99.0 + index,
        rating: 4.5 + (index * 0.1) % 0.5,
        category: categoryKey,
        tags: ['technical', 'index'],
        annualReturn: (5 + index * 2.5) * (index % 2 == 0 ? 1 : -1),
        sharpeRatio: 1.5 + index * 0.1,
        maxDrawdown: 2.0 + index * 0.3,
        winRate: 60 + index * 2,
      );
    });

    setState(() {
      _strategies.addAll(filteredStrategies);
      _total = filteredStrategies.length;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Total strategies: $_total',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
        ),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: _strategies.length,
          itemBuilder: (context, index) {
            return StrategyCard(strategy: _strategies[index]);
          },
        ),
        if (_strategies.length < _total)
          Padding(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Load More'),
            ),
          ),
      ],
    );
  }
}

class _Strategy {
  final int id;
  final String name;
  final String description;
  final String author;
  final double price;
  final double rating;
  final String category;
  final List<String> tags;
  final double annualReturn;
  final double sharpeRatio;
  final double maxDrawdown;
  final double winRate;
}
