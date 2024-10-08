import 'package:flutter/material.dart';
import 'package:krushi_setu/screens/login.dart';
import 'package:krushi_setu/screens/seller_dashboard.dart';
import 'package:krushi_setu/screens/seller_question.dart';
import '../demo.dart';
import '../widgets/category_button.dart';
import '../widgets/farmer_avater.dart';
import '../widgets/product_card.dart';
import '../models/product.dart';
import 'marketplace.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> fetchProducts() async {
  await dotenv.load(fileName: "assets/.env");
  String apiUrl =  dotenv.env['API_URL']!;

  final response = await http.get(Uri.parse("$apiUrl/products"));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

    final List<dynamic> productsJson = (jsonResponse['data']['docs'] as List<dynamic>?) ?? [];
    return productsJson.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOpen = false;
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchBarVisible = false;
  final TextEditingController _searchController = TextEditingController(); //for search bar
  Future<List<Product>>? _productsFuture; // Store the future

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Fetch products once when the widget is initialized
    _productsFuture = fetchProducts(); // Call the API only once
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        setState(() {
          _isSearchBarVisible = false;
        });
      }
    });
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Demo()));
        break;
      case 2:
        if (!isOpen) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerDashboard()));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerQuestion()));
        }
        isOpen = !isOpen;
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Demo()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Demo()));
        break;
    }
  }

  void _toggleSearchBar() {
    setState(() {
      _isSearchBarVisible = !_isSearchBarVisible;
      if (_isSearchBarVisible) {
        FocusScope.of(context).requestFocus(_searchFocusNode);
      } else {
        FocusScope.of(context).unfocus();
      }
    });
  }

  void _performSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Marketplace()),
    );
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
            onPressed: _toggleSearchBar,
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            icon: const Icon(Icons.menu),
          ),
        ],
        bottom: _isSearchBarVisible
            ? PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 50.0,
            curve: Curves.easeInOut,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _performSearch,
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
        )
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return ListView(
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
                        children: snapshot.data!.map((product) {
                          return ProductCard(
                            title: product.name,
                            price: '₹${product.price}',
                            sellerName: product.sellerName,
                            productImageUrl: product.productImageUrl,
                            sellerImageUrl: product.sellerImageUrl,
                            description: product.description,
                            quantity: product.quantity,
                          );
                        }).toList(),
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
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onNavBarTapped,
      ),
    );
  }
}
