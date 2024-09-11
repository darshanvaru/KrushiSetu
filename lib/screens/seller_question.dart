import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals; // Import the global class

class SellerQuestion extends StatefulWidget {
  const SellerQuestion({super.key});

  @override
  State<SellerQuestion> createState() => _SellerQuestionState();
}

class _SellerQuestionState extends State<SellerQuestion> {
  String? _selectedOption;
  String _cardNumber = '';
  final List<String> _options = ['Land Number', 'Shrum V Card Number'];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Please select and enter one of the following:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedOption,
                hint: const Text('Choose an option'),
                items: _options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Option',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an option';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Number',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _cardNumber = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Prepare the data
                    final documentType = _selectedOption == 'Land Number'
                        ? 'landNumber'
                        : 'shramYogiCardNumber';

                    final requestData = {
                      "seller": globals.Globals.uid,
                      "documentNumber": _cardNumber,
                      "documentType": documentType,
                    };
                    print('-------------------------------------------------');
                    print('Global data: ${globals.Globals.uid}');
                    print('-------------------------------------------------');

                    // Send POST request
                    final response = await http.post(
                      Uri.parse('http://10.150.150.1:5050/api/v1/documents'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(requestData),
                    );

                    // Log response details for debugging
                    print('-------------------------------------------------');
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');
                    print('-------------------------------------------------');

                    if (response.statusCode == 200) {
                      // Successfully sent data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReviewConfirmationPage(),
                        ),
                      );
                    } else {
                      // Handle the error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to submit data: ${response.body}'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewConfirmationPage extends StatelessWidget {
  const ReviewConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Review'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Your profile will be reviewed and verified.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('Go Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
