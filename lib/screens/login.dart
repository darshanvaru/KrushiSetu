import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:krushi_setu/screens/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailOrMobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final emailOrMobile = _emailOrMobileController.text;
    final password = _passwordController.text;

    try {
      // Step 1: Login
      final loginResponse = await http.post(
        Uri.parse('http://10.150.150.1:5050/api/v1/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': emailOrMobile,
          'password': password,
        }),
      );

      if (loginResponse.statusCode == 200) {
        print('Login successful');

        // Step 2: Fetch user details
        final userResponse = await http.get(
          Uri.parse('http://10.150.150.1:5050/api/v1/users'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // Add any necessary authentication headers here
          },
        );

        if (userResponse.statusCode == 200) {
          final userResponseBody = jsonDecode(userResponse.body);
          print('User details response: $userResponseBody');

          // Extract user ID from the response
          String? userId;
          if (userResponseBody is Map<String, dynamic> &&
              userResponseBody['data'] is Map<String, dynamic> &&
              userResponseBody['data']['docs'] is List &&
              userResponseBody['data']['docs'].isNotEmpty) {
            userId = userResponseBody['data']['docs'][0]['_id']?.toString();
          }

          if (userId != null) {
            // Store user_id using SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_id', userId);

            print('User ID stored: $userId');

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Successful')),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else {
            throw Exception('User ID not found in response');
          }
        } else {
          throw Exception('Failed to fetch user details');
        }
      } else {
        final errorResponse = jsonDecode(loginResponse.body);
        final errorMessage = errorResponse['message'] ?? 'Login Failed';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Error during login process: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              const Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Email or Mobile no. input
              SizedBox(
                width: screenWidth * 0.85,
                child: TextFormField(
                  controller: _emailOrMobileController,
                  decoration: const InputDecoration(
                    labelText: 'Email or Mobile no.',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 16),

              // Password input
              SizedBox(
                width: screenWidth * 0.85,
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),

              // Forgot password
              const Align(
                alignment: Alignment.centerRight,
                child: SizedBox(height: 10),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: screenWidth * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Login button
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Text('Login', style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignupScreen()),
                            );
                          },
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}