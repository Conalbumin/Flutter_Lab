import 'package:flutter/material.dart';
import 'cart.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
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
                SnackBar(content: Text('Payment Successful')),
              );
            },
            child: Text('Complete Purchase'),
          ),
        ],
      ),
    );
  }
}
