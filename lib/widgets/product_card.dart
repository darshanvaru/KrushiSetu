import 'package:flutter/material.dart';
import '../screens/product_detail.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String sellerName;
  final String productImageUrl;
  final String sellerImageUrl;

  const ProductCard({
    required this.title,
    required this.price,
    required this.sellerName,
    required this.productImageUrl,
    required this.sellerImageUrl,
    super.key,
  });

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
              owner: sellerName,
              imageUrl: productImageUrl,
              ownerUrl: sellerImageUrl,
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
              child: Image.network(
                productImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Text(
                        "Photo error",
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
                    child: Image.network(
                      sellerImageUrl,
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
                Text(sellerName, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
