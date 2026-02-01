/// Strategy Data Model
class StrategyData {
  final int id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String category;
  final List<String> tags;
  final double annualReturn;
  final double sharpeRatio;
  final double maxDrawdown;
  final double winRate;

  const StrategyData({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.tags,
    required this.annualReturn,
    required this.sharpeRatio,
    required this.maxDrawdown,
    required this.winRate,
  });
}
