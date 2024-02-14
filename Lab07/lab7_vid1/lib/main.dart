import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (ctx) => MyHomePage(),
      '/about': (ctx) => SecondPage(message: 'Hi',),
      '/contact': (ctx) => ThirdPage()
    },
    onGenerateRoute: (settings) {
      var args = settings.arguments;
      switch (settings.name) {
        case '/':
          return MaterialPageRoute(builder: (ctx) => MyHomePage());
        case '/about':
          return MaterialPageRoute(builder: (ctx) => SecondPage(message: args.toString(),));
        case '/contact':
          return MaterialPageRoute(builder: (ctx) => ThirdPage());

        default:
          return MaterialPageRoute(builder: (ctx) => Scaffold(
            appBar: AppBar(title: const Text('Not found'),),
          ));
      }
    },
  ));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = 'Home Page';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Home'),
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud),
        onPressed: () {
          Navigator.pushNamed(context, '/about', arguments: 'This is named route');
        },
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  String message;
  SecondPage({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Second'),
      ),
      body: Container(
        color: Colors.grey,
        alignment: Alignment.center,
        child: Text(
          message,
          style: const TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud),
        onPressed: () {
          Navigator.pushNamed(context, '/contact');
        },
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Third'),
      ),
      body: Container(
        color: Colors.blueGrey,
        alignment: Alignment.center,
        child: const Text(
          'Third Page',
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud),
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
      ),
    );
  }
}
