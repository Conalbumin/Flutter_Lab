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
  int index = 0;
  var labels = ['Home', 'History', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
            child: Text(
          'Bottom Navigation',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Center(
          child: Text(
        labels[index],
        style: const TextStyle(fontSize: 30),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upcoming),
        onPressed: () {
          setState(() {
            index = (index + 1) % 3 ;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (idx) {
          setState(() {
            index = idx;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),

        ],),
    );
  }
}
