import 'package:flutter/material.dart';

class StrategyFilter extends StatefulWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategoryChange;

  const StrategyFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChange,
  });

  @override
  State<StrategyFilter> createState() => _StrategyFilterState();
}

class _StrategyFilterState extends State<StrategyFilter> {
  final List<String> _categories = ['all', 'forex', 'crypto', 'stocks', 'commodities', 'futures'];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate API loading
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        const Text(
          'Strategy Category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        if (_isLoading)
          Row(
            children: const [
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 16),
              Text('Loading categories...'),
            ],
          )
        else
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _categories.map((category) {
              final isSelected = widget.selectedCategory == category;
              return ChoiceChip(
                label: Text(category.toUpperCase()),
                selected: isSelected,
                onSelected: (_) => widget.onCategoryChange(category),
                selectedColor: Theme.of(context).colorScheme.primary,
                labelStyle: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
