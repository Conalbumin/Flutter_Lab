import 'package:flutter/material.dart';
import 'cart.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title: const Text('Checkout', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total: \$${Cart.getTotal().toString()}'),
          // Add payment and shipping information fields
          ElevatedButton(
            onPressed: () {
              // Implement payment processing
              Cart.items.clear();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment Successful')),
              );
            },
            child: const Text('Complete Purchase'),
          ),
        ],
      ),
    );
  }
}
