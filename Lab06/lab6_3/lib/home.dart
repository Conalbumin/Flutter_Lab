import 'package:flutter/material.dart';
import 'product.dart';

class HomePage extends StatelessWidget {
  final List<Product> products = List.generate(15, (index) {
    return Product(
      name: 'Product ${index + 1}',
      price: (index + 1) * 10,
      imageUrl: 'assets/toeic.png',
    );
  });


  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      backgroundColor: Colors.greenAccent.shade100,
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
                  builder: (context) =>
                      ProductDetailPage(product: products[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
