class Restaurant {
  final String name;
  final String cuisine;
  final double rating;
  final String deliveryTime;
  final List<Provider> providers;

  Restaurant({
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.deliveryTime,
    required this.providers,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    var providersList = json['providers'] as List;
    List<Provider> providers = providersList.map((i) => Provider.fromJson(i)).toList();
    
    return Restaurant(
      name: json['name'],
      cuisine: json['cuisine'],
      rating: json['rating'].toDouble(),
      deliveryTime: json['deliveryTime'],
      providers: providers,
    );
  }
}

class Provider {
  final String name;
  final double price;
  final int discount;
  final double deliveryFee;
  final bool available;
  final bool exclusive;
  final String discountType;

  Provider({
    required this.name,
    required this.price,
    required this.discount,
    required this.deliveryFee,
    required this.available,
    required this.exclusive,
    this.discountType = 'flat',
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      name: json['name'],
      price: json['price'].toDouble(),
      discount: json['discount'],
      deliveryFee: json['deliveryFee'].toDouble(),
      available: json['available'],
      exclusive: json['exclusive'] ?? false,
      discountType: json['discountType'] ?? 'flat',
    );
  }
}
