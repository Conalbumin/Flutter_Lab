import 'package:flutter/material.dart';
import 'cart.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();

  String? _validateFormField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  AlertDialog _completedPurchase() {
    return AlertDialog(
      title: const Text('Thank you for shopping with us'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              username.clear();
              address.clear();
              phone.clear();
              Navigator.of(context).pop();
            });
          },
          child: const Text('Reset'),
        ),
      ],
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // If all fields are valid, perform the completed purchase action
      showDialog(
        context: context,
        builder: (context) {
          return _completedPurchase();
        },
      );
    } else {
      // If any field is not valid, show error messages
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid information for all fields.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                keyboardType: TextInputType.text,
                validator: _validateFormField,
                controller: username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                keyboardType: TextInputType.text,
                validator: _validateFormField,
                controller: address,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.car_repair),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: _validateFormField,
                controller: phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.contact_phone),
                ),
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 3,
            child: BottomAppBar(
              color: Colors.teal,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${Cart.getTotal().toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: BottomAppBar(
              color: Colors.red,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: _handleSubmit, // Call _handleSubmit when completed is tapped
                  child: const Text(
                    'Completed',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
