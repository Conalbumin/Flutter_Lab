import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(
        maxScreens: 12,
        currentScreen: 1,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final int maxScreens;
  final int currentScreen;

  const MyApp({Key? key, required this.maxScreens, required this.currentScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Screen $currentScreen',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            top: 100,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                for (int i = 1; i <= maxScreens; i++)
                  GestureDetector(
                    onTap: () {
                      if (i < currentScreen) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApp(
                                maxScreens: maxScreens,
                                currentScreen: i,
                              ),
                            )
                        );
                      } else if (i > currentScreen) {
                        if (i - currentScreen <= 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApp(
                                maxScreens: maxScreens,
                                currentScreen: i,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: 20,
                        width: 50,
                        color: i <= currentScreen - 1 ? Colors.blue : Colors.grey,
                        child: Center(
                          child: Text(
                            '$i',
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 26,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              child: const Icon(Icons.skip_next, color: Colors.white, size: 30),
              onPressed: () {
                if (currentScreen < maxScreens) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(
                        maxScreens: maxScreens,
                        currentScreen: currentScreen + 1,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Positioned(
            top: 26,
            left: MediaQuery.of(context).size.width / 2 - 10,
            child: Text(
              '$currentScreen',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
