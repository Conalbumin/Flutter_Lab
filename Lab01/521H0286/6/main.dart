import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50), // Add some spacing between groups
            Expanded(
              child: Column(
                children: [
                  const Text('Align Start', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                  Container(
                    height: 100,
                    color: Colors.blue.shade800,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  const Text('Align Center', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                  Container(
                    height: 100,
                    color: Colors.blue.shade800,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                     Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  const Text('Align End', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                  Container(
                    height: 100,
                    color: Colors.blue.shade800,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                     Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  const Text('Align Space Around', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                  Container(
                    height: 100,
                    color: Colors.blue.shade800,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                   Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  const Text('Align Space Between', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                  Container(
                    height: 100,
                    color: Colors.blue.shade800,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                   Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  const Text('Align Space Evenly', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                  Container(
                    height: 100,
                    color: Colors.blue.shade800,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                   Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                        Icon(Icons.star, size: 70, color: Colors.white,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
