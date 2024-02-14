import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
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
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Simple Dialog',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          message,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          var value = await showDialog(
              barrierDismissible: true,
              barrierColor: Colors.green.withOpacity(0.25),
              context: context,
              builder: (ct) => AlertDialog(
                    title: const Text('Reset'),
                    content: Text('Are you sure to reset device?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text('Cancel')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text('OK')),
                      // SimpleDialogOption(
                      //   child: const Text('Vietnam'),
                      //   onPressed: () {
                      //     Navigator.pop(context, 'Vietnam');
                      //   },
                      // ),
                      // SimpleDialogOption(
                      //   child: const Text('Laos'),
                      //   onPressed: () {
                      //     Navigator.pop(context, 'Laos');
                      //   },
                      // ),
                      // SimpleDialogOption(
                      //   child: const Text('Cambodia'),
                      //   onPressed: () {
                      //     Navigator.pop(context, 'Cambodia');
                      //   },
                      // )
                    ],
                  ));
        },
      ),
    );
  }
}
