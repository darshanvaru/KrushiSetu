import 'package:flutter/material.dart';
import '../demo.dart';
import '../services/seller_service.dart'; // Ensure this import is correct
import '../widgets/category_button.dart';
import '../widgets/farmer_avater.dart';
import '../widgets/product_card.dart';
import '../services/product_service.dart'; // Import the service
import '../models/product.dart';
import 'marketplace.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchBarVisible = false;
  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
      // Handle Home
        break;
      case 1:
      // Handle Orders
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Demo()));
        break;
      case 2:
      // Handle Add Button
        _handleAddButtonPressed();
        break;
      case 3:
      // Handle Farmers
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Demo()));
        break;
      case 4:
      // Handle Cart
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Demo()));
        break;
    }
  }

  void _handleAddButtonPressed() {
    // Use a method to handle seller status check and navigation
    SellerService().checkSellerStatus(context);
  }

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        setState(() {
          _isSearchBarVisible = false;
        });
      }
    });
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
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
            future: fetchProducts(),
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
