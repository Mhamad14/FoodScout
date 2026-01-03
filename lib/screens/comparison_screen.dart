import 'package:flutter/material.dart';
import '../models/comparison_result.dart';
import '../services/api_service.dart';
import '../widgets/comparison_card.dart';
import '../localization/app_localizations.dart';

class ComparisonScreen extends StatefulWidget {
  final String restaurantName;

  const ComparisonScreen({
    Key? key,
    required this.restaurantName,
  }) : super(key: key);

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  final ApiService _apiService = ApiService();
  ComparisonResult? _comparisonResult;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadComparison();
  }

  Future<void> _loadComparison() async {
    try {
      final result = await _apiService.comparePrices(widget.restaurantName);
      if (mounted) {
        setState(() {
          _comparisonResult = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to fetch comparison data.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${loc.get('comparing')} ${widget.restaurantName}'),
        centerTitle: true,
      ),
      body: _buildBody(theme, loc),
    );
  }

  Widget _buildBody(ThemeData theme, AppLocalizations loc) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
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
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _error = null;
                });
                _loadComparison();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_comparisonResult != null) {
      // Sort results by total price (best deal first)
      final sortedResults = List.from(_comparisonResult!.results)
        ..sort((a, b) => a.total.compareTo(b.total));

      if (sortedResults.isEmpty) {
        return Center(
          child: Text(loc.get('noRestaurants')),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sortedResults.length,
        itemBuilder: (context, index) {
          final providerResult = sortedResults[index];
          final isCheapest = providerResult.provider == _comparisonResult!.cheapestProvider;
          return ComparisonCard(
            result: providerResult,
            isCheapest: isCheapest,
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}
