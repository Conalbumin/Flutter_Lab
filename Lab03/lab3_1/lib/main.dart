import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var products = [
    {"Product Name": "Apple iPhone 12", "Price": 799.00},
    {"Product Name": "Samsung Galaxy S21", "Price": 799.00},
    {"Product Name": "Google Pixel 6", "Price": 699.00},
    {"Product Name": "OnePlus 9 Pro", "Price": 729.00},
    {"Product Name": "MacBook Air M2", "Price": 999.00},
    {"Product Name": "MacBook Pro M1", "Price": 1299.00},
    {"Product Name": "iPad Pro", "Price": 799.00},
    {"Product Name": "Microsoft Surface Pro 7", "Price": 799.00},
    {"Product Name": "Dell XPS 13", "Price": 999.00},
    {"Product Name": "HP Spectre x360", "Price": 1099.00},
    {"Product Name": "Acer Chromebook Spin 713", "Price": 599.00},
    {"Product Name": "Lenovo ThinkPad X1 Carbon", "Price": 1399.00},
    {"Product Name": "Bose QuietComfort 35 II", "Price": 349.00},
    {"Product Name": "Beats Solo Pro", "Price": 299.00},
    {"Product Name": "JBL Flip 5", "Price": 99.00},
    {"Product Name": "Sonos Move", "Price": 399.00},
    {"Product Name": "Bose SoundLink Micro", "Price": 99.00},
    {"Product Name": "UE Boom 3", "Price": 149.00},
    {"Product Name": "JBL Charge 4", "Price": 149.00},
    {"Product Name": "Bose SoundLink Mini II", "Price": 199.00}
  ];

  Widget _objToProduct(obj) {
    String title = obj['Product Name'];
    String subtitle = obj['Price'].toString();
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Center(child: Text(
              'Listview', style: TextStyle(color: Colors.white),))),
        body: ListView.separated( // cach 3
          separatorBuilder: (context, index) => const Divider(
            height: 10,
            color: Colors.grey,),
          itemBuilder: ((context, index) => _objToProduct(products[index])),
          itemCount: products.length,)

      // cach 1
      // ListView(
      //   children: products.map(_objToProduct).toList(),
      // ),

      // cach 2
      // ListView.builder(
      //    itemBuilder: ((context, index) => _objToProduct(products[index])),
      //    itemCount: products.length,)

        );
  }
}
