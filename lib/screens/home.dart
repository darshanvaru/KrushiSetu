import 'package:flutter/material.dart';

import '../widgets/category_button.dart';
import '../widgets/farmer_avater.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Handler for adding a product to the cart
  void _onAddToCart(Map<String, dynamic> product) {
    // Logic for adding product to cart can be handled here
    // You can use a provider or a state management solution to handle the cart functionality
    print('Added to cart: ${product['title']}');
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                "Shop By Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryButton("Veggies", true),
                    SizedBox(width: 10),
                    CategoryButton("Fruits", false),
                    SizedBox(width: 10),
                    CategoryButton("Dairy Products", false),
                    SizedBox(width: 10),
                    CategoryButton("Farming machines", false),
                    SizedBox(width: 10),
                    CategoryButton("Miscellaneous", false),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  "Recently Listed",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: TextButton(onPressed: () {}, child: const Text("View all")),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ProductCard(
                      "Fresh Local Vine Tomatoes (5kg)",
                      "12.80/kg",
                      "J. RameshBhai",
                      "assets/tomato.jpg",
                      "assets/farmer1.jpg",
                      onAddToCart: (product) => _onAddToCart(product), // Pass the onAddToCart handler
                    ),
                    ProductCard(
                      "2kg Fresh Potatoes",
                      "34.53/2kg",
                      "S. ShofikBhai",
                      "assets/potato.jpg",
                      "assets/farmer3.jpg",
                      onAddToCart: (product) => _onAddToCart(product), // Pass the onAddToCart handler
                    ),
                    ProductCard(
                      "Golden Carrot",
                      "28.33/2kg",
                      "A. ChimanBhai",
                      "assets/carrot.jpg",
                      "assets/farmer4.jpg",
                      onAddToCart: (product) => _onAddToCart(product), // Pass the onAddToCart handler
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  "Best Farmers",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: TextButton(onPressed: () {}, child: const Text("View all")),
              ),
              const SizedBox(height: 10),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FarmerAvatar("D. RameshBhai", "4.9", "assets/farmer1.jpg"),
                    FarmerAvatar("V. AshokBhai", "4.7", "assets/farmer2.jpg"),
                    FarmerAvatar("S. ShofikBhai", "4.8", "assets/farmer3.jpg"),
                    FarmerAvatar("A. ChimanBhai", "4.6", "assets/farmer4.jpg"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Farmers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}