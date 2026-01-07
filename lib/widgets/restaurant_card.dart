import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../providers/favorites_provider.dart';
import '../localization/app_localizations.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  const RestaurantCard({
    Key? key,
    required this.restaurant,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final bestProvider = restaurant.providers.reduce((a, b) => a.discount > b.discount ? a : b);
    final maxDiscount = bestProvider.discount;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // margin: const EdgeInsets.only(bottom: 16), // Removed to let GridView handle spacing and fix overflow
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 105, // Reduced from 120 to fix vertical gaps/squaring
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getCuisineColor(restaurant.cuisine).withOpacity(0.8),
                      _getCuisineColor(restaurant.cuisine).withOpacity(0.6),
                    ],
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getCuisineIcon(restaurant.cuisine),
                            size: 32, // Slightly smaller icon
                            color: Colors.white,
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              loc.get(restaurant.cuisine.toLowerCase().replaceAll(' ', '')), 
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11, // Slightly smaller text
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (maxDiscount > 0)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getDiscountText(loc, maxDiscount, bestProvider.discountType),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    // Favorite Button ... same logic for pos ...
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Consumer<FavoritesProvider>(
                        builder: (context, favoritesProvider, child) {
                          final isFavorite = favoritesProvider.isFavorite(restaurant.name);
                          return GestureDetector(
                            onTap: () {
                              favoritesProvider.toggleFavorite(restaurant.name);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6), // Smaller padding
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                                size: 18, // Smaller icon
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10), // Reduced from 12
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                    Text(
                      restaurant.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13, // Slight tweak
                      ),
                      maxLines: 1, // Restrict to 1 line if possible? No 2 is safer.
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2), // Tighter
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 13,
                          color: Colors.amber[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating.toStringAsFixed(1),
                          style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.access_time,
                          size: 13,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.deliveryTime,
                          style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: restaurant.providers
                          .take(3)
                          .map((provider) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getProviderColor(provider.name)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  provider.name,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: _getProviderColor(provider.name),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCuisineColor(String cuisine) {
    switch (cuisine.toLowerCase()) {
      case 'fast food':
      case 'burgers':
        return Colors.red;
      case 'pizza':
        return Colors.orange;
      case 'middle eastern':
      case 'kebab':
      case 'shawarma':
        return Colors.green;
      case 'asian':
      case 'sushi':
      case 'chinese':
        return Colors.purple;
      case 'healthy':
      case 'vegan':
      case 'salads':
        return Colors.teal;
      case 'coffee':
      case 'cafe':
        return Colors.brown;
      case 'desserts':
      case 'ice cream':
        return Colors.pink;
      case 'seafood':
      case 'grilled fish':
        return Colors.blue;
      default:
        return Colors.indigo;
    }
  }

  IconData _getCuisineIcon(String cuisine) {
    switch (cuisine.toLowerCase()) {
      case 'fast food':
      case 'burgers':
        return Icons.fastfood;
      case 'pizza':
        return Icons.local_pizza;
      case 'middle eastern':
      case 'kebab':
      case 'shawarma':
        return Icons.kebab_dining;
      case 'asian':
      case 'sushi':
      case 'chinese':
        return Icons.ramen_dining;
      case 'healthy':
      case 'vegan':
      case 'salads':
        return Icons.eco;
      case 'coffee':
      case 'cafe':
        return Icons.coffee;
      case 'desserts':
      case 'ice cream':
        return Icons.cake;
      case 'seafood':
      case 'grilled fish':
        return Icons.set_meal;
      default:
        return Icons.restaurant;
    }
  }

  Color _getProviderColor(String provider) {
    switch (provider) {
      case 'Toters':
        return Colors.green;
      case 'Talabat':
        return Colors.orange;
      case 'Lezzo':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  String _getDiscountText(AppLocalizations loc, int discount, String type) {
    String prefix = '';
    if (type == 'under') {
      prefix = loc.get('under');
    } else if (type == 'upto') {
      prefix = loc.get('upto');
    } else {
      return '$discount% ${loc.get('off')}';
    }
    
    return '$prefix $discount% ${loc.get('off')}';
  }
}
