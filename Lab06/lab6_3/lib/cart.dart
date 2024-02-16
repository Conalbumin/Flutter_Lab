import 'package:flutter/material.dart';
import 'product.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title: const Text('Cart', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: Cart.items.length,
        itemBuilder: (context, index) {
          final product = Cart.items.keys.toList()[index];
          final quantity = Cart.items.values.toList()[index];
          return ListTile(
            title: Text('${product.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\$${product.price.toString()}', style: const TextStyle(fontSize: 20, color: Colors.deepOrange)),
                Text('Quantity: $quantity', style: const TextStyle(fontSize: 16)),
              ],
            ),
            leading: CircleAvatar(
              backgroundImage: AssetImage(product.imageUrl),
              radius: 30,
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${Cart.getTotal().toStringAsFixed(2)}', // Format total cost to two decimal places
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              ElevatedButton(
                style: ButtonStyle(

                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cart {
  static Map<Product, int> items = {}; // Use a map to track product quantity

  static void addItem(Product product) {
    items.update(product, (value) => value + 1, ifAbsent: () => 1);
  }

  static double getTotal() {
    double total = 0;
    for (var entry in items.entries) {
      total += entry.key.price * entry.value; // Multiply price by quantity
    }
    return total;
  }
}
