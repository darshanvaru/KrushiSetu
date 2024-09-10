import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

Future<List<Product>> fetchProducts() async {

  await dotenv.load(fileName: "assets/.env");
  String apiUrl =  dotenv.env['API_URL']!;

  final response = await http.get(Uri.parse("$apiUrl/products"));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

    // Extract the list of products from the 'data' -> 'docs' field
    final List<dynamic> productsJson = (jsonResponse['data']['docs'] as List<dynamic>?) ?? [];
    return productsJson.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
