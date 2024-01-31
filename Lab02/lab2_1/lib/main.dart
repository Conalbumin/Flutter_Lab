import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.yellow  ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(width: 3)
                ),
              ),

              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(width: 3)
                ),
              ),

              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(width: 3)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


