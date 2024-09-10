import 'package:flutter/material.dart';

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
