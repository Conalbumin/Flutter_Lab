import 'package:flutter/material.dart';
import 'cart.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title:
            const Text('Product Detail', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 500,
              height: 400,
              child: Image.asset(product.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.additionalImages != null &&
                      product.additionalImages!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.additionalImages!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset(
                                  product.additionalImages![index],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ), // Additional Images
                  Text(
                    '\$${product.price.toString()}',
                    style: const TextStyle(fontSize: 36),
                  ), // Price
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ), // Name
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Description: ',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: product.description,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ), // Description

                  if (product.review != null) // Display review if available
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Review: ',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: product.review!,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ), // Review
// Review
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Cart.addItem(product);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${product.name} added to cart')),
          );
        },
        backgroundColor: Colors.teal, // Set the background color of the FAB
        child: const Icon(Icons.add_shopping_cart, color: Colors.white),
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String? review; // Optional review field
  final List<String>? additionalImages; // Optional list of additional images
  final String description; // Description field

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.review,
    this.additionalImages,
    required this.description, // Include description in the constructor
  });
}
