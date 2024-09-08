import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Robert Mertiz"),
            Text("Los Angeles", style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Shop By Categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 10),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 35,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CategoryButton("Veggies", true),
                        SizedBox(width: 16),
                        CategoryButton("Fruits", false),
                        SizedBox(width: 16),
                        CategoryButton("Dairy Products", false),
                        SizedBox(width: 16),
                        CategoryButton("Farming machines", false),
                        SizedBox(width: 16),
                        CategoryButton("Miscellaneous", false),
                      ],
                    ),
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
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProductCard("Fresh Local Vine Tomatoes (5kg)", "\$12.80/kg", "assets/tomato.jpg"),
                      SizedBox(width: 10),
                      ProductCard("2kg Fresh Potatoes", "\$34.53/2kg", "assets/potato.jpg"),
                      SizedBox(width: 10),
                      ProductCard("Golden Carrot", "\$28.33/2kg", "assets/carrot.jpg"),
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
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    children: const [
                      FarmerAvatar("D. Anaste", "4.9", "assets/farmer1.jpg"),
                      FarmerAvatar("M. Orhard", "4.7", "assets/farmer2.jpg"),
                      FarmerAvatar("S. Medow", "4.8", "assets/farmer3.jpg"),
                      FarmerAvatar("F. Acrest", "4.6", "assets/farmer4.jpg"),
                    ],
                  ),
                ),
              ],
            ),
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

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryButton(this.label, this.isSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green : Colors.grey[200],
        shape: const StadiumBorder(),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard(this.title, this.price, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Text(
                      "Image not found",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(price, style: const TextStyle(color: Colors.green)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: const StadiumBorder(),
              minimumSize: const Size(40, 40),
            ),
            child: const Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class FarmerAvatar extends StatelessWidget {
  final String name;
  final String rating;
  final String imageUrl;

  const FarmerAvatar(this.name, this.rating, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: ClipOval(
              child: Image.asset(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.person, size: 30, color: Colors.grey[400]);
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            rating,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
