import 'package:flutter/material.dart';
import 'product.dart';
import 'cart.dart';

class HomePage extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Product 1', price: 10, imageUrl: 'assets/product1.jpg'),
    Product(name: 'Product 2', price: 20, imageUrl: 'assets/product2.jpg'),
    Product(name: 'Product 3', price: 30, imageUrl: 'assets/product3.jpg'),
    // Add more products here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toString()}'),
            leading: CircleAvatar(
              backgroundImage: AssetImage(products[index].imageUrl),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: products[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
