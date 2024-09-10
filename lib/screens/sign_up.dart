import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'title': String title,
      } =>
          Album(
            id: id,
            title: title,
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenWidth * 0.85, // Dynamic width based on screen size
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: screenWidth * 0.85, // Dynamic width based on screen size
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: screenWidth * 0.85, // Dynamic width based on screen size
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Mobile No.',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: screenWidth * 0.85, // Dynamic width based on screen size
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: screenWidth * 0.85, // Dynamic width based on screen size
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: screenWidth * 0.85, // Dynamic width based on screen size
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Shipping Address',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: screenWidth * 0.85, // Dynamic width based on screen size
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}