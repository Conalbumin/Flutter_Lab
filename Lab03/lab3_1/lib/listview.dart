import 'package:flutter/material.dart';
import 'products.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
        body:  ListView(
          children: products.map(_objToProduct).toList(),
        ),
    );
  }
}
