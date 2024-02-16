import 'package:flutter/material.dart';
import 'product.dart';
import 'checkout.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/checkout');
        },
        child: Icon(Icons.check),
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
