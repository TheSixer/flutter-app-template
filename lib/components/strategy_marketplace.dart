import 'package:flutter/material.dart';
import 'strategy_card.dart';
import '../models/strategy_data.dart';

class StrategyCardWidget extends StatelessWidget {
  final StrategyData strategy;

  const StrategyCardWidget({required this.strategy});

  @override
  Widget build(BuildContext context) {
    return StrategyCard(strategy: strategy);
  }
}

class StrategyMarketplace extends StatelessWidget {
  const StrategyMarketplace({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: const Column(
        children: [
          Text(
            'Strategy Market',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Explore professional trading strategies',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 48),
          _StrategySearch(),
          SizedBox(height: 24),
          _StrategyFilter(),
          SizedBox(height: 32),
          _StrategyGrid(),
        ],
      ),
    );
  }
}

class _StrategySearch extends StatefulWidget {
  const _StrategySearch();

  @override
  State<_StrategySearch> createState() => _StrategySearchState();
}

class _StrategySearchState extends State<_StrategySearch> {
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchTerm = value;
          });
        },
        decoration: const InputDecoration(
          hintText: 'Search strategies by name, author, or tags...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}

class _StrategyFilter extends StatelessWidget {
  const _StrategyFilter();

  @override
  Widget build(BuildContext context) {
    final categories = const ['All', 'Forex', 'Crypto', 'Stocks', 'Commodities', 'Futures'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Strategy Category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: categories.map((category) {
            final isSelected = category.toLowerCase() == 'all';
            return FilterChip(
              label: Text(category.toUpperCase()),
              selected: isSelected,
              onSelected: (_) {},
              selectedColor: Theme.of(context).colorScheme.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _StrategyGrid extends StatelessWidget {
  const _StrategyGrid();

  @override
  Widget build(BuildContext context) {
    final strategies = List.generate(12, (index) => StrategyData(
      id: index,
      name: 'Strategy $index',
      description: 'Advanced trading strategy for market',
      price: 99.0 + index,
      rating: 4.5 + (index * 0.1) % 0.5,
      category: ['Forex', 'Crypto', 'Stocks', 'Commodities', 'Futures'][index % 5],
      tags: ['Technical', 'Index'],
      annualReturn: (5 + index * 2.5) * (index % 2 == 0 ? 1 : -1),
    ));

    return Column(
      children: [
        Text(
          'Total strategies: ${strategies.length}',
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
          itemCount: strategies.length,
          itemBuilder: (context, index) {
            return StrategyCardWidget(strategy: strategies[index]);
          },
        ),
        if (strategies.length >= 12)
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
