import 'package:flutter/material.dart';
import 'strategy_card_widget.dart';
import '../models/strategy_data.dart';
import '../services/strategy_service.dart';

class StrategyMarketplace extends StatefulWidget {
  const StrategyMarketplace({super.key});

  @override
  State<StrategyMarketplace> createState() => _StrategyMarketplaceState();
}

class _StrategyMarketplaceState extends State<StrategyMarketplace> {
  String _searchTerm = '';
  String _selectedCategory = 'all';
  List<StrategyData> _strategies = [];
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadStrategies();
  }

  void _loadCategories() async {
    final categories = await StrategyService.getDictData('strategy_category');
    setState(() {
      _categories = categories;
    });
  }

  void _loadStrategies({int page = 1}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      if (page == 1) {
        _strategies = [];
      }
    });

    try {
      final category = _selectedCategory == 'all' ? null : _selectedCategory;
      final response = await StrategyService.getStrategiesPage(
        pageNo: page,
        pageSize: 12,
        strategyCategory: category,
        params: _searchTerm.isEmpty ? null : _searchTerm,
      );

      setState(() {
        if (page == 1) {
          _strategies = response.map((json) => _convertToStrategyData(json)).toList();
        } else {
          _strategies.addAll(response.map((json) => _convertToStrategyData(json)));
        }
        _total = _strategies.length;
        _hasMore = _strategies.length >= _total;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading strategies: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  StrategyData _convertToStrategyData(Map<String, dynamic> json) {
    final category = json['strategyCategory'] ?? 'other';
    final tags = json['moduleTags']?.toString().split(',') ?? [];

    return StrategyData(
      id: json['strategyId'] ?? 0,
      name: json['strategyName'] ?? 'Unknown',
      description: json['strategyBrief'] ?? '',
      price: json['payPrice'] ?? 0.0,
      rating: json['strategyPositive'] != null
        ? (json['strategyPositive'] as num).toDouble() / 20.0
        : 0.0,
      category: category,
      tags: tags.isNotEmpty ? tags : ['technical'],
      annualReturn: 0.0,
      sharpeRatio: 0.0,
      maxDrawdown: 0.0,
      winRate: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          const Text(
            'Strategy Market',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Explore professional trading strategies',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          StrategySearch(
            value: _searchTerm,
            onChanged: (value) {
              setState(() {
                _searchTerm = value;
                _currentPage = 1;
              });
              _loadStrategies(page: 1);
            },
          ),
          const SizedBox(height: 24),
          StrategyFilter(
            selectedCategory: _selectedCategory,
            onCategoryChange: (category) {
              setState(() {
                _selectedCategory = category;
                _currentPage = 1;
              });
              _loadStrategies(page: 1);
            },
            categories: _categories,
          ),
          const SizedBox(height: 32),
          _buildStrategyGrid(),
        ],
      ),
    );
  }

  Widget _buildStrategyGrid() {
    if (_isLoading && _strategies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_strategies.isEmpty) {
      return const Center(
        child: Text('No strategies found'),
      );
    }

    return Column(
      children: [
        Text(
          'Total strategies: ${_total}',
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
            return StrategyCardWidget(strategy: _strategies[index]);
          },
        ),
        if (_hasMore && !_isLoading)
          Padding(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentPage++;
                });
                _loadStrategies(page: _currentPage);
              },
              child: const Text('Load More'),
            ),
          ),
        if (_isLoading)
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
      ],
    );
  }
}
