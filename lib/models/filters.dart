class RestaurantFilters {
  String? searchQuery;
  List<String> selectedCuisines;
  double? minRating;
  int? minDiscount;
  bool? availableOnly;
  List<String> selectedProviders;
  int? maxDeliveryTime;
  double? maxPrice;
  bool? freeDeliveryOnly;
  String? sortBy;

  RestaurantFilters({
    this.searchQuery,
    this.selectedCuisines = const [],
    this.minRating,
    this.minDiscount,
    this.availableOnly = true,
    this.selectedProviders = const [],
    this.maxDeliveryTime,
    this.maxPrice,
    this.freeDeliveryOnly = false,
    this.sortBy,
  });

  RestaurantFilters copyWith({
    String? searchQuery,
    List<String>? selectedCuisines,
    double? minRating,
    int? minDiscount,
    bool? availableOnly,
    List<String>? selectedProviders,
    int? maxDeliveryTime,
    double? maxPrice,
    bool? freeDeliveryOnly,
    String? sortBy,
  }) {
    return RestaurantFilters(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCuisines: selectedCuisines ?? this.selectedCuisines,
      minRating: minRating ?? this.minRating,
      minDiscount: minDiscount ?? this.minDiscount,
      availableOnly: availableOnly ?? this.availableOnly,
      selectedProviders: selectedProviders ?? this.selectedProviders,
      maxDeliveryTime: maxDeliveryTime ?? this.maxDeliveryTime,
      maxPrice: maxPrice ?? this.maxPrice,
      freeDeliveryOnly: freeDeliveryOnly ?? this.freeDeliveryOnly,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  void clear() {
    searchQuery = null;
    selectedCuisines = [];
    minRating = null;
    minDiscount = null;
    availableOnly = true;
    selectedProviders = [];
    maxDeliveryTime = null;
    maxPrice = null;
    freeDeliveryOnly = false;
    sortBy = null;
  }

  bool get hasActiveFilters =>
      searchQuery != null ||
      selectedCuisines.isNotEmpty ||
      minRating != null ||
      minDiscount != null ||
      maxDeliveryTime != null ||
      maxPrice != null ||
      freeDeliveryOnly == true ||
      sortBy != null ||
      (selectedProviders.isNotEmpty);
}

class FilterOptions {
  static const List<String> cuisines = [
    'Kebab',
    'Traditional Iraqi',
    'Kurdish Cuisine',
    'Shawarma',
    'Fast Food',
    'Pizza',
    'Fried Chicken',
    'Grilled Fish',
    'Biryani',
    'Falafel',
    'Lahmajun',
    'Kubba',
    'Breakfast',
    'Desserts',
    'Ice Cream',
    'Cafe',
    'Juices',
    'Sandwiches',
    'Sushi',
    'Chinese',
    'Italian',
    'Lebanese',
    'Healthy',
    'Salads',
    'Vegan',
    'Burgers',
    'Steak',
    'Seafood',
    'Fine Dining',
  ];

  static const List<String> providers = [
    'Talabat',
    'Lezzo',
    'Toters',
  ];

  static const List<double> ratingOptions = [
    3.0,
    3.5,
    4.0,
    4.5,
  ];

  static const List<int> discountOptions = [
    10,
    20,
    30,
    40,
    50,
  ];

  static const List<int> deliveryTimeOptions = [
    30,
    45,
    60,
  ];

  static const List<double> priceOptions = [
    10.0,
    20.0,
    35.0,
    50.0,
  ];

  static const List<String> sortOptions = [
    'Rating',
    'Price: Low to High',
    'Price: High to Low',
    'Delivery Time',
    'Discount',
  ];
}
