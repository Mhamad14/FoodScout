import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/comparison_result.dart';
import '../models/restaurant.dart';
import '../models/filters.dart';
import '../services/api_service.dart';
import '../widgets/comparison_card.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../providers/theme_provider.dart';
import '../localization/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  
  // Dashboard State
  List<Restaurant>? _allRestaurants;
  List<Restaurant>? _filteredRestaurants;
  bool _isLoadingRestaurants = true;
  RestaurantFilters _filters = RestaurantFilters();

  // Comparison State
  ComparisonResult? _comparisonResult;
  bool _isComparing = false;
  String? _error;
  String? _selectedRestaurantName;

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRestaurants() async {
    try {
      final restaurants = await _apiService.fetchRestaurants();
      setState(() {
        _allRestaurants = restaurants;
        _filteredRestaurants = restaurants;
        _isLoadingRestaurants = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load restaurants. Ensure backend is running.';
        _isLoadingRestaurants = false;
      });
    }
  }

  void _onSearchChanged() {
    setState(() {
      _filters.searchQuery = _searchController.text;
    });
    _applyFilters();
  }

  void _applyFilters() {
    if (_allRestaurants == null) return;

    setState(() {
      var filtered = _allRestaurants!.where((restaurant) {
        // Search filter
        if (_filters.searchQuery != null && _filters.searchQuery!.isNotEmpty) {
          if (!restaurant.name.toLowerCase().contains(_filters.searchQuery!.toLowerCase()) &&
              !restaurant.cuisine.toLowerCase().contains(_filters.searchQuery!.toLowerCase())) {
            return false;
          }
        }

        // Cuisine filter
        if (_filters.selectedCuisines.isNotEmpty) {
          if (!_filters.selectedCuisines.contains(restaurant.cuisine)) {
            return false;
          }
        }

        // Rating filter
        if (_filters.minRating != null) {
          if (restaurant.rating < _filters.minRating!) {
            return false;
          }
        }

        // Discount filter (min discount)
        if (_filters.minDiscount != null) {
          final maxDiscount = restaurant.providers
              .map((p) => p.discount)
              .reduce((a, b) => a > b ? a : b);
          if (maxDiscount < _filters.minDiscount!) {
            return false;
          }
        }

        // Provider filter
        if (_filters.selectedProviders.isNotEmpty) {
          final hasSelectedProvider = restaurant.providers
              .any((provider) => _filters.selectedProviders.contains(provider.name));
          if (!hasSelectedProvider) {
            return false;
          }
        }

        // Delivery time filter
        if (_filters.maxDeliveryTime != null) {
          // Parse delivery time like "25-35 min" -> take max (35)
          final timeStr = restaurant.deliveryTime;
          final match = RegExp(r'(\d+)-(\d+)').firstMatch(timeStr);
          if (match != null) {
            final maxTime = int.tryParse(match.group(2) ?? '0') ?? 0;
            if (maxTime > _filters.maxDeliveryTime!) {
              return false;
            }
          }
        }

        // Price filter
        if (_filters.maxPrice != null) {
          final minPrice = restaurant.providers
              .map((p) => p.price)
              .reduce((a, b) => a < b ? a : b);
          if (minPrice > _filters.maxPrice!) {
            return false;
          }
        }

        // Free delivery filter
        if (_filters.freeDeliveryOnly == true) {
          final hasFreeDelivery = restaurant.providers
              .any((p) => p.deliveryFee == 0);
          if (!hasFreeDelivery) {
            return false;
          }
        }

        return true;
      }).toList();

      // Apply sorting
      if (_filters.sortBy != null) {
        switch (_filters.sortBy) {
          case 'Rating':
            filtered.sort((a, b) => b.rating.compareTo(a.rating));
            break;
          case 'Price: Low to High':
            filtered.sort((a, b) {
              final aMin = a.providers.map((p) => p.price).reduce((x, y) => x < y ? x : y);
              final bMin = b.providers.map((p) => p.price).reduce((x, y) => x < y ? x : y);
              return aMin.compareTo(bMin);
            });
            break;
          case 'Price: High to Low':
            filtered.sort((a, b) {
              final aMin = a.providers.map((p) => p.price).reduce((x, y) => x < y ? x : y);
              final bMin = b.providers.map((p) => p.price).reduce((x, y) => x < y ? x : y);
              return bMin.compareTo(aMin);
            });
            break;
          case 'Delivery Time':
            filtered.sort((a, b) {
              final aMatch = RegExp(r'(\d+)-(\d+)').firstMatch(a.deliveryTime);
              final bMatch = RegExp(r'(\d+)-(\d+)').firstMatch(b.deliveryTime);
              final aTime = int.tryParse(aMatch?.group(1) ?? '0') ?? 0;
              final bTime = int.tryParse(bMatch?.group(1) ?? '0') ?? 0;
              return aTime.compareTo(bTime);
            });
            break;
          case 'Discount':
            filtered.sort((a, b) {
              final aMax = a.providers.map((p) => p.discount).reduce((x, y) => x > y ? x : y);
              final bMax = b.providers.map((p) => p.discount).reduce((x, y) => x > y ? x : y);
              return bMax.compareTo(aMax);
            });
            break;
        }
      }

      _filteredRestaurants = filtered;
    });
  }


  Future<void> _compare(String restaurantName) async {
    setState(() {
      _selectedRestaurantName = restaurantName;
      _isComparing = true;
      _error = null;
      _comparisonResult = null;
    });

    try {
      final result = await _apiService.comparePrices(restaurantName);
      setState(() {
        _comparisonResult = result;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to fetch comparison data.';
      });
    } finally {
      setState(() {
        _isComparing = false;
      });
    }
  }

  void _clearComparison() {
    setState(() {
      _comparisonResult = null;
      _selectedRestaurantName = null;
      _error = null;
    });
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        filters: _filters,
        onFiltersChanged: (newFilters) {
          setState(() {
            _filters = newFilters;
            _searchController.text = _filters.searchQuery ?? '';
          });
          _applyFilters();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: CustomScrollView(
            slivers: [
              _buildAppBar(theme, loc),
              if (_selectedRestaurantName == null) ...[
                _buildSearchAndFilters(theme, loc),
                _buildRestaurantGrid(theme, loc),
              ] else ...[
                _buildComparisonView(theme),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(ThemeData theme, AppLocalizations loc) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      leading: _selectedRestaurantName != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _clearComparison,
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          _selectedRestaurantName != null 
              ? '${loc.get('comparing')} $_selectedRestaurantName' 
              : loc.get('appTitle'),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        titlePadding: EdgeInsets.only(
          left: _selectedRestaurantName != null ? 56 : 16, 
          bottom: 16,
          right: 56,
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary.withOpacity(0.1),
                theme.colorScheme.secondary.withOpacity(0.1),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return PopupMenuButton<ThemeMode>(
              icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onSelected: (ThemeMode mode) {
                themeProvider.setThemeMode(mode);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: ThemeMode.light,
                  child: Row(
                    children: [
                      Icon(Icons.light_mode),
                      SizedBox(width: 8),
                      Text('Light'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: ThemeMode.dark,
                  child: Row(
                    children: [
                      Icon(Icons.dark_mode),
                      SizedBox(width: 8),
                      Text('Dark'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: ThemeMode.system,
                  child: Row(
                    children: [
                      Icon(Icons.settings_brightness),
                      SizedBox(width: 8),
                      Text('System'),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters(ThemeData theme, AppLocalizations loc) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: loc.get('searchHint'),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _filters.hasActiveFilters
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _filters.clear();
                            _searchController.clear();
                          });
                          _applyFilters();
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _showFilters,
                    icon: const Icon(Icons.tune),
                    label: Text('${loc.get('filters')}${_filters.hasActiveFilters ? ' (${_getActiveFilterCount()})' : ''}'),
                  ),
                ),
                const SizedBox(width: 12),
                if (_filteredRestaurants != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_filteredRestaurants!.length} ${loc.get('results')}',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantGrid(ThemeData theme, AppLocalizations loc) {
    if (_isLoadingRestaurants) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
              const SizedBox(height: 16),
              Text(
                _error!,
                style: TextStyle(color: theme.colorScheme.error),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadRestaurants,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_filteredRestaurants == null || _filteredRestaurants!.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_outlined, size: 64, color: theme.colorScheme.onSurface.withOpacity(0.3)),
              const SizedBox(height: 16),
              Text(
                loc.get('noRestaurants'),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                loc.get('adjustFilters'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Responsive Grid Logic
    final width = MediaQuery.of(context).size.width;
    // Calculate available width for the grid (capped at 1200 due to constraint)
    final gridWidth = width > 1200 ? 1200 : width;
    
    int crossAxisCount = 2;
    double childAspectRatio = 0.68; // Mobile ratio (much shorter card than before)

    if (gridWidth > 1000) {
      crossAxisCount = 4;
      childAspectRatio = 0.92; // Desktop (almost square)
    } else if (gridWidth > 600) {
      crossAxisCount = 3;
      childAspectRatio = 0.82; // Tablet
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final restaurant = _filteredRestaurants![index];
            return RestaurantCard(
              restaurant: restaurant,
              onTap: () => _compare(restaurant.name),
            );
          },
          childCount: _filteredRestaurants!.length,
        ),
      ),
    );
  }

  Widget _buildComparisonView(ThemeData theme) {
    if (_isComparing) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
              const SizedBox(height: 16),
              Text(
                _error!,
                style: TextStyle(color: theme.colorScheme.error),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (_comparisonResult != null) {
      // Sort results by total price (best deal first)
      final sortedResults = List.from(_comparisonResult!.results)
        ..sort((a, b) => a.total.compareTo(b.total));
      
      return SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final providerResult = sortedResults[index];
              final isCheapest = providerResult.provider == _comparisonResult!.cheapestProvider;
              return ComparisonCard(
                result: providerResult,
                isCheapest: isCheapest,
              );
            },
            childCount: sortedResults.length,
          ),
        ),
      );
    }

    return const SliverFillRemaining(child: SizedBox.shrink());
  }

  int _getActiveFilterCount() {
    int count = 0;
    if (_filters.selectedCuisines.isNotEmpty) count++;
    if (_filters.minRating != null) count++;
    if (_filters.minDiscount != null) count++;
    if (_filters.selectedProviders.isNotEmpty) count++;
    if (_filters.maxDeliveryTime != null) count++;
    if (_filters.maxPrice != null) count++;
    if (_filters.freeDeliveryOnly == true) count++;
    if (_filters.sortBy != null) count++;
    return count;
  }
}
