import 'package:flutter/material.dart';
import 'home.dart';
import 'checkout.dart';
import 'cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/cart': (context) => CartPage(),
        '/checkout': (context) => CheckoutPage(),
      },
    );
  }
}
