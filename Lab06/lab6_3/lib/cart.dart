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
                  onTap: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                  child: const Text(
                    'Checkout',
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
