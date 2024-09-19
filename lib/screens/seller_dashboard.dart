// seller_dashboard.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../globals.dart';
import '../widgets/product_card.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({super.key});

  @override
  _SellerDashboardState createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  late Future<List<dynamic>> _products;

  @override
  void initState() {
    super.initState();
    _products = fetchProducts();
  }

  Future<List<dynamic>> fetchProducts() async {
    await dotenv.load(fileName: "assets/.env");
    final apiUrl = dotenv.env['API_URL'];
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/products?seller=${Globals.uid}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${Globals.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Check if 'data' and 'docs' are present and are lists
        if (data['data'] != null && data['data']['docs'] is List) {
          return data['data']['docs'];
        } else {
          print('Unexpected data format: ${data['data']}');
          return [];
        }
      } else {
        throw Exception('Failed to load products: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<List<dynamic>>(
          future: _products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products available.'));
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.data!.map<Widget>((product) {
                    return ProductCard(
                      title: product['name'] ?? 'No Title',
                      price: product['price'].toString() ?? 'No Price',
                      sellerName: product['seller']['name'] ?? 'No Seller Name',
                      productImageUrl: product['images'].isNotEmpty ? product['images'][0] : '', // Assuming images is a list of URLs
                      sellerImageUrl: '', // No seller image URL provided in JSON
                      description: product['description'] ?? 'No Description',
                      quantity: product['quantity'] ?? 0,
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
