import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'login.dart';

void main() async {
  try {
    await dotenv.load(fileName: "assets/.env");
    print('Environment variables loaded: ${dotenv.env}');
  } catch (e) {
    print('Error loading .env file: $e');
  }

  String apiUrl = dotenv.env['API_URL'] ?? '';
  String apiKey = dotenv.env['API_KEY'] ?? '';
  print("--------------------");
  print("{$apiUrl}, {$apiKey} ");
  print("--------------------");
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}