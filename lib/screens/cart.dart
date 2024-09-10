// import 'package:flutter/material.dart';
//
// class CartScreen extends StatelessWidget {
//   final String title;
//   final String price;
//   final String imageUrl;
//
//   CartScreen({
//     required this.title,
//     required this.price,
//     required this.imageUrl,
//     Key? key,
//   }) : super(key: key);
//
//   double get totalCartPrice {
//     return cartItems.fold(0, (total, item) {
//       return total + (item['product']['price'] as double) * (item['quantity'] as int);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Cart'),
//       ),
//       body: cartItems.isEmpty
//           ? Center(child: Text('Your cart is empty.'))
//           : Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = cartItems[index];
//                 return ListTile(
//                   leading: Image.network(item['product']['image'], width: 50),
//                   title: Text(item['product']['name']),
//                   subtitle: Text('Quantity: ${item['quantity']}'),
//                   trailing: Text(
//                     'Total: \$${(item['product']['price'] * item['quantity']).toStringAsFixed(2)}',
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'Total: \$${totalCartPrice.toStringAsFixed(2)}',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Purchase complete!')),
//                       );
//                     },
//                     child: Text('Buy Now'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
