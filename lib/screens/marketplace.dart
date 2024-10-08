import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:krushi_setu/screens/product_detail.dart';

class Marketplace extends StatefulWidget {
  const Marketplace({super.key});

  @override
  MarketplaceState createState() => MarketplaceState();
}

class MarketplaceState extends State<Marketplace> {
  List<dynamic> products = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    await dotenv.load(fileName: "assets/.env");
    final apiUrl = dotenv.env['API_URL'];

    if (apiUrl == null) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      return;
    }

    final url = '$apiUrl/products';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          products = jsonData['data']['docs'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
        throw Exception('Failed to load products');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      // print('Error fetching products: $error'); // Add logging for debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Darshan Varu"),
            Text("Rajkot", style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
          ? const Center(child: Text('Failed to load products'))
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final productName = product['name'] ?? 'Unknown Product';
          final productPrice = product['price'] != null
              ? '₹${product['price']}'
              : 'Unknown Price';
          final sellerName = product['seller']?['name'] ?? 'Unknown Seller';
          final productImage = (product['images'] != null && product['images'].isNotEmpty)
              ? product['images'][0] // If image exists
              : ''; // Placeholder for missing image
          final description = product['description'] ?? 'No Description';
          final quantity = product['quantity'];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                leading: SizedBox(
                  width: 80,
                  height: 80, // Adjust height as needed
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: productImage.isNotEmpty
                        ? Image.network(
                      productImage,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text(
                          'No Photo',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(productName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productPrice),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey[200],
                          child: Text(
                            sellerName.isNotEmpty ? sellerName[0] : 'U', // Display first letter of seller's name
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          sellerName,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        title: productName,
                        price: productPrice,
                        owner: sellerName,
                        imageUrl: productImage,
                        ownerUrl: '', // Adjust as needed
                        description: description,
                        quantity: quantity,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
