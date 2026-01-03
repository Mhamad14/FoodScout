import 'package:flutter/material.dart';
import '../models/filters.dart';
import '../localization/app_localizations.dart';

class FilterBottomSheet extends StatefulWidget {
  final RestaurantFilters filters;
  final Function(RestaurantFilters) onFiltersChanged;

  const FilterBottomSheet({
    Key? key,
    required this.filters,
    required this.onFiltersChanged,
  }) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late List<String> selectedCuisines;
  late double? minRating;
  late int? minDiscount;
  late List<String> selectedProviders;
  late int? maxDeliveryTime;
  late double? maxPrice;
  late bool freeDeliveryOnly;
  late String? sortBy;

  @override
  void initState() {
    super.initState();
    selectedCuisines = List.from(widget.filters.selectedCuisines);
    minRating = widget.filters.minRating;
    minDiscount = widget.filters.minDiscount;
    selectedProviders = List.from(widget.filters.selectedProviders);
    maxDeliveryTime = widget.filters.maxDeliveryTime;
    maxPrice = widget.filters.maxPrice;
    freeDeliveryOnly = widget.filters.freeDeliveryOnly ?? false;
    sortBy = widget.filters.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loc.get('filters'),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: _clearFilters,
                      child: Text(loc.get('clearAll')),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildSection(loc.get('sortBy'), _buildSortFilter(loc)),
                    const SizedBox(height: 24),
                    _buildSection(loc.get('cuisine'), _buildCuisineFilters(loc)),
                    const SizedBox(height: 24),
                    _buildSection(loc.get('minRating'), _buildRatingFilter()),
                    const SizedBox(height: 24),
                    _buildSection(loc.get('minDiscount'), _buildDiscountFilter(loc)),
                    const SizedBox(height: 24),
                    _buildSection(loc.get('deliveryTime'), _buildDeliveryTimeFilter(loc)),
                    const SizedBox(height: 24),
                    _buildSection(loc.get('maxPrice'), _buildPriceFilter(loc)),
                    const SizedBox(height: 24),
                    _buildSection(loc.get('deliveryOptions'), _buildDeliveryOptionFilter(loc)),
                    const SizedBox(height: 24),
                    _buildSection(loc.get('providers'), _buildProviderFilters()),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                 child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(loc.get('cancel')),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _applyFilters,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(loc.get('applyFilters')),
                    ),
                  ),
                ],
              ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(String title, Widget child) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildChipLabel(String text, {IconData? icon, Color? iconColor}) {
    // Using Roboto for filters to ensure numbers and Latin text align correctly (Speda has odd metrics for 10K etc)
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: iconColor ?? Theme.of(context).iconTheme.color),
          const SizedBox(width: 6),
        ],
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Roboto', 
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSortFilter(AppLocalizations loc) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: FilterOptions.sortOptions.map((option) {
        final isSelected = sortBy == option;
        String localizedOption = option;
        if (option == 'Rating') localizedOption = loc.get('rating');
        else if (option == 'Price: Low to High') localizedOption = loc.get('priceLowHigh');
        else if (option == 'Price: High to Low') localizedOption = loc.get('priceHighLow');
        else if (option == 'Delivery Time') localizedOption = loc.get('deliveryTime');
        else if (option == 'Discount') localizedOption = loc.get('discount');
        
        return FilterChip(
          label: _buildChipLabel(localizedOption),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              sortBy = selected ? option : null;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildCuisineFilters(AppLocalizations loc) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FilterChip(
          label: _buildChipLabel(loc.get('all')),
          selected: selectedCuisines.isEmpty,
          onSelected: (selected) {
            setState(() {
              selectedCuisines.clear();
            });
          },
        ),
        ...FilterOptions.cuisines.map((cuisine) {
          // Map hardcoded cuisine names to localized strings
          String localizedCuisine = loc.get(
            cuisine.toLowerCase()
              .split(' ')
              .map((word) => word.isNotEmpty ? word[0].toLowerCase() + word.substring(1) : '')
              .join('')
              .replaceAll(' ', '')
          );
          // Fallback if mapping fails (e.g. for simple single words like Pizza, Kebab)
          if (localizedCuisine == cuisine.toLowerCase()) {
             if (cuisine == 'Fast Food') localizedCuisine = loc.get('fastFood');
             else if (cuisine == 'Grilled Fish') localizedCuisine = loc.get('grilledFish');
             else if (cuisine == 'Fried Chicken') localizedCuisine = loc.get('friedChicken');
             else if (cuisine == 'Traditional Iraqi') localizedCuisine = loc.get('traditionalIraqi');
             else if (cuisine == 'Kurdish Cuisine') localizedCuisine = loc.get('kurdishCuisine');
             else localizedCuisine = loc.get(cuisine.toLowerCase());
          }
           
          return FilterChip(
            label: _buildChipLabel(localizedCuisine),
            selected: selectedCuisines.contains(cuisine),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  selectedCuisines.add(cuisine);
                } else {
                  selectedCuisines.remove(cuisine);
                }
              });
            },
          );
        }).toList(),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: FilterOptions.ratingOptions.map((rating) {
        final isSelected = minRating == rating;
        return FilterChip(
          label: _buildChipLabel(
            '${rating.toStringAsFixed(1)}+',
            icon: Icons.star,
            iconColor: Colors.amber,
          ),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              minRating = selected ? rating : null;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildDiscountFilter(AppLocalizations loc) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: FilterOptions.discountOptions.map((discount) {
        final isSelected = minDiscount == discount;
        return FilterChip(
          label: _buildChipLabel('$discount% ${loc.get('off')}'),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              minDiscount = selected ? discount : null;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildDeliveryTimeFilter(AppLocalizations loc) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: FilterOptions.deliveryTimeOptions.map((minutes) {
        final isSelected = maxDeliveryTime == minutes;
        return FilterChip(
          label: _buildChipLabel('${loc.get('under')} $minutes ${loc.get('min')}'),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              maxDeliveryTime = selected ? minutes : null;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildPriceFilter(AppLocalizations loc) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: FilterOptions.priceOptions.map((price) {
        final isSelected = maxPrice == price;
        return FilterChip(
          label: _buildChipLabel('${loc.get('under')} ${price.toInt()}K IQD'),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              maxPrice = selected ? price : null;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildDeliveryOptionFilter(AppLocalizations loc) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Switch(
          value: freeDeliveryOnly,
          onChanged: (value) {
            setState(() {
              freeDeliveryOnly = value;
            });
          },
        ),
        const SizedBox(width: 8),
        Text(
          'Free Delivery Only',
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildProviderFilters() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: FilterOptions.providers.map((provider) {
        final isSelected = selectedProviders.contains(provider);
        return FilterChip(
          label: _buildChipLabel(provider),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                selectedProviders.add(provider);
              } else {
                selectedProviders.remove(provider);
              }
            });
          },
        );
      }).toList(),
    );
  }

  void _clearFilters() {
    setState(() {
      selectedCuisines = [];
      minRating = null;
      minDiscount = null;
      selectedProviders = [];
      maxDeliveryTime = null;
      maxPrice = null;
      freeDeliveryOnly = false;
      sortBy = null;
    });
  }

  void _applyFilters() {
    // Create new filters directly instead of using copyWith
    // to properly handle null values for clearing filters
    final newFilters = RestaurantFilters(
      searchQuery: widget.filters.searchQuery,
      selectedCuisines: selectedCuisines,
      minRating: minRating,
      minDiscount: minDiscount,
      availableOnly: widget.filters.availableOnly,
      selectedProviders: selectedProviders,
      maxDeliveryTime: maxDeliveryTime,
      maxPrice: maxPrice,
      freeDeliveryOnly: freeDeliveryOnly,
      sortBy: sortBy,
    );
    
    widget.onFiltersChanged(newFilters);
    Navigator.of(context).pop();
  }
}
