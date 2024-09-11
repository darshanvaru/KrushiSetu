// models/product.dart
class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final int quantity;
  final String sellerName;
  final String productImageUrl;
  final String sellerImageUrl;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.quantity,
    required this.sellerName,
    required this.productImageUrl,
    required this.sellerImageUrl,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final seller = json['seller'] as Map<String, dynamic>?;

    return Product(
      id: json['_id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      quantity: json['quantity'] as int,
      sellerName: seller?['name'] as String? ?? 'Unknown Seller',
      productImageUrl: json['productImageUrl'] as String? ?? 'assets/default_image.jpg',
      sellerImageUrl: seller?['photo'] as String? ?? 'assets/default_seller.jpg',
      description: json['description'] as String? ?? 'No Description',
    );
  }
}