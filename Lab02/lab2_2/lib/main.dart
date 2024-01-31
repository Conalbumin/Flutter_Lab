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
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xFFCF8A88), border: Border.all(width: 3)
                  ),
                  child: const Text('A', style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),

                Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xFFCF8A88), border: Border.all(width: 3)
                  ),
                  child: const Text('B', style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),

                Expanded(
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xFFCF8A88), border: Border.all(width: 3)
                    ),
                    child: const Text('C', style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              flex: 1,
              child: Container(
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xFFBD9335), border: Border.all(width: 3)
                ),
                child: const Text('D', style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xFFA4CE9F), border: Border.all(width: 3)
                ),
                child: const Text('E', style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ], // children
        )
      ),
    );
  }
}
