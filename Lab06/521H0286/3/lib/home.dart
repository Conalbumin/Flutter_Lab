import 'package:flutter/material.dart';
import 'product.dart';

class HomePage extends StatelessWidget {
  final List<Product> products = List.generate(15, (index) {
    return Product(
      name: 'Product ${index + 1}',
      price: (index + 1) * 10,
      imageUrl: 'assets/toeic.png',
      review: 'This is a good choice',
      additionalImages: ['assets/toeic.png', 'assets/toeic.png'], // Example of providing a list of additional images
      description: 'Add detailed description for Product ${index + 1} is here', // Provide description for each product
    );
  });


  HomePage({Key? key}) : super(key: key);

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
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name, style: const TextStyle(fontSize: 18)),
            subtitle: Text('\$${products[index].price.toString()}', style: const TextStyle(fontSize: 15)),
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
