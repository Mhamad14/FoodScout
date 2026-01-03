import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comparison_result.dart';
import '../models/restaurant.dart';

class ApiService {
  // For Android emulator, use 10.0.2.2. For iOS/Web/Windows, use localhost.
  static const String baseUrl = 'http://localhost:3000'; 

  Future<List<Restaurant>> fetchRestaurants() async {
    final response = await http.get(Uri.parse('$baseUrl/restaurants'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Restaurant.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<ComparisonResult> comparePrices(String restaurantName) async {
    final response = await http.get(
      Uri.parse('$baseUrl/compare?restaurant=$restaurantName'),
    );

    if (response.statusCode == 200) {
      return ComparisonResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load comparison data');
    }
  }
}
