class ComparisonResult {
  final String query;
  final String cheapestProvider;
  final int maxDiscount;
  final List<ProviderResult> results;

  ComparisonResult({
    required this.query,
    required this.cheapestProvider,
    required this.maxDiscount,
    required this.results,
  });

  factory ComparisonResult.fromJson(Map<String, dynamic> json) {
    return ComparisonResult(
      query: json['query'],
      cheapestProvider: json['cheapestProvider'],
      maxDiscount: json['maxDiscount'],
      results: (json['results'] as List)
          .map((i) => ProviderResult.fromJson(i))
          .toList(),
    );
  }
}

class ProviderResult {
  final String provider;
  final String restaurant;
  final double originalPrice;
  final int discount;
  final double deliveryFee;
  final double total;
  final bool available;
  final bool exclusive;
  final double rating;
  final String deliveryTime;

  ProviderResult({
    required this.provider,
    required this.restaurant,
    required this.originalPrice,
    required this.discount,
    required this.deliveryFee,
    required this.total,
    required this.available,
    required this.exclusive,
    required this.rating,
    required this.deliveryTime,
  });

  factory ProviderResult.fromJson(Map<String, dynamic> json) {
    return ProviderResult(
      provider: json['provider'],
      restaurant: json['restaurant'],
      originalPrice: json['originalPrice'].toDouble(),
      discount: json['discount'],
      deliveryFee: json['deliveryFee'].toDouble(),
      total: json['total'].toDouble(),
      available: json['available'],
      exclusive: json['exclusive'] ?? false,
      rating: json['rating'].toDouble(),
      deliveryTime: json['deliveryTime'],
    );
  }
}
