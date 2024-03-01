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
              'Listview.builder', style: TextStyle(color: Colors.white),))),
        // body: ListView.separated( // cach 3
        //   separatorBuilder: (context, index) => const Divider(
        //     height: 10,
        //     color: Colors.grey,),
        //   itemBuilder: ((context, index) => _objToProduct(products[index])),
        //   itemCount: products.length,)

      // cach 1
      // ListView(
      //   children: products.map(_objToProduct).toList(),
      // ),

      body:  ListView.builder(
        itemBuilder: ((context, index) => _objToProduct(products[index])),
        itemCount: products.length)
      // cach 2
      // ListView.builder(
      //    itemBuilder: ((context, index) => _objToProduct(products[index])),
      //    itemCount: products.length,)

        );
  }
}
