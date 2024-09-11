import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../globals.dart';
import '../screens/review_confirmation.dart';
import '../screens/seller_question.dart';
import '../screens/seller_dashboard.dart';

class SellerService {
  // Define base URLs and endpoints
  final String baseUrl = 'http://10.150.150.1:5050/api/v1';
  final String userEndpoint = '/users';
  final String documentEndpoint = '/documents';

  Future<void> checkSellerStatus(BuildContext context) async {
    try {
      // Fetch user verification status
      final userResponse = await http.get(
        Uri.parse('$baseUrl$userEndpoint/${Globals.uid}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${Globals.token}',
        },
      );

      if (userResponse.statusCode == 200) {
        final userResponseData = jsonDecode(userResponse.body);
        final userVerificationStatus = userResponseData['data']['docs']['isVerified'];
        print("_____________________________________________________");
        print("${userResponse.body}");
        print("${userVerificationStatus}");
        print("_____________________________________________________");

        // Fetch document verification status
        final docResponse = await http.get(
          Uri.parse('$baseUrl$documentEndpoint/${Globals.uid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${Globals.token}',
          },
        );

        if (docResponse.statusCode == 200) {
          final docResponseData = jsonDecode(docResponse.body);
          final docVerificationStatus = docResponseData['data']['docs']['isVerified'];
          print("_____________________________________________________");
          print("${docResponse.body}");
          print("${docVerificationStatus}");
          print("_____________________________________________________");

          // Navigate based on verification status
          if (userVerificationStatus == null || docVerificationStatus == null) {
            print("_____________________________________________________");
            print("_____________________________________________________");
            print("NULL");
            print("_____________________________________________________");
            print("_____________________________________________________");
          } else if (userVerificationStatus) {
            if (docVerificationStatus) {
              // Both user and document are verified
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SellerDashboard(),
                ),
              );
            } else {
              // User is verified but document is not verified
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReviewConfirmationPage(),
                ),
              );
            }
          } else {
            // User is not verified
            if (!docVerificationStatus) {
              // Document is also not verified
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SellerQuestion(),
                ),
              );
            }
          }
        } else {
          // Document API error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to fetch document verification status: ${docResponse.body}'),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SellerQuestion(),
            ),
          );
        }
      } else {
        // User API error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch user verification status: ${userResponse.body}'),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SellerQuestion(),
          ),
        );
      }
    } catch (e) {
      // Handle exception
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('An error occurred: $e'),
      //   ),
      // );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SellerQuestion(),
        ),
      );
    }
  }
}
