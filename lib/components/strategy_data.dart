class _StrategyData {
  final int id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String category;
  final List<String> tags;
  final double annualReturn;

  const _StrategyData({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.tags,
    required this.annualReturn,
  });
}
