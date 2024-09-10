import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final String title;
  final String price;
  final String owner;
  final String imageUrl;
  final String ownerUrl;

  const ProductDetail({
    required this.title,
    required this.price,
    required this.owner,
    required this.imageUrl,
    required this.ownerUrl,
    super.key,
  });

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                widget.imageUrl,
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
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "${widget.price}",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: Image.network(
                      widget.ownerUrl,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person, size: 24, color: Colors.grey[400]);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.owner,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Common background color
                    borderRadius: BorderRadius.circular(30), // Rounded edges for container
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
                        child: Container(
                          color: Colors.grey[400], // Darker background for left button
                          child: IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: _decrementQuantity,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Center(
                          child: Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontSize: 24, // Adjust this value as needed
                              fontWeight: FontWeight.bold, // Optional: to make the text bold
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
                        child: Container(
                          color: Colors.grey[400], // Darker background for right button
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: _incrementQuantity,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
