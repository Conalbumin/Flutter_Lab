import 'package:flutter/material.dart';
import 'product.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title: const Text('Cart', style: TextStyle(color: Colors.white),),
      ),
      body: ListView.builder(
        itemCount: Cart.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(Cart.items[index].name),
            subtitle: Text('\$${Cart.items[index].price.toString()}'),
            leading: CircleAvatar(
              backgroundImage: AssetImage(Cart.items[index].imageUrl),
            ),
          );
        },
      ),
      backgroundColor: Colors.greenAccent.shade100,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/checkout');
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

class Cart {
  static List<Product> items = [];

  static void addItem(Product product) {
    items.add(product);
  }

  static double getTotal() {
    double total = 0;
    for (var item in items) {
      total += item.price;
    }
    return total;
  }
}
