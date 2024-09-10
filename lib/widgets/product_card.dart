import 'package:flutter/material.dart';
import '../screens/product_detail.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String owner;
  final String ownerUrl;
  final String imageUrl;
  final Function(Map<String, dynamic>) onAddToCart; // Added onAddToCart

  const ProductCard(this.title, this.price, this.owner, this.imageUrl, this.ownerUrl, {required this.onAddToCart, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              title: title,
              price: price,
              owner: owner,
              imageUrl: imageUrl,
              ownerUrl: ownerUrl,
              onAddToCart: onAddToCart, // Pass the onAddToCart function
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
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
            Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: Image.asset(
                      ownerUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person, size: 30, color: Colors.grey[400]);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Text(owner, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
