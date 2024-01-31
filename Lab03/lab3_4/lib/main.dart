import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var products = [
    {"Product Name": "Apple iPhone 12", "Price": 799.00},
    // ... (other products)
  ];

  // List to keep track of selected state for each item
  List<bool> selectedItems = List.generate(20, (index) => false);

  Widget _productToGrid(int index) {
    Map<String, dynamic> product = products[index];
    String name = product['Product Name'];
    String price = product['Price'].toString();

    return InkWell(
      onTap: () {
        // Handle tap event
      },
      onLongPress: () {
        // Handle long-press event
        setState(() {
          selectedItems[index] = !selectedItems[index];
        });
      },
      child: Card(
        elevation: 5,
        color: selectedItems[index] ? Colors.grey : Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(price, style: TextStyle(fontSize: 16, color: Colors.amber)),
                ],
              ),
            ),
            selectedItems[index]
                ? Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 40.0,
            )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text('GridView', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            crossAxisCount: 3,
          ),
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return _productToGrid(index);
          },
        ),
      ),
    );
  }
}
