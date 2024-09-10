import 'package:flutter/material.dart';
import 'package:krushi_setu/screens/sign_up.dart';

import 'home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                width: screenWidth * 0.85, // Dynamic width based on screen size
                child: TextFormField(
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
                width: screenWidth * 0.85, // Dynamic width based on screen size
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),

              //forgot password
              const Align(
                alignment: Alignment.centerRight,
                child:SizedBox(height: 10),
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
                width: screenWidth * 0.85, // Dynamic width based on screen size
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    //login button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
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

                        //sign up button
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