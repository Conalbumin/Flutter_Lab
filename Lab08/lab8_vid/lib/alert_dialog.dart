import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  const Alert({super.key});

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  String message = "dw";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        backgroundColor: Colors.blue,
        title: Text("Alert Dialog"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          message,
          style: TextStyle(fontSize: 50),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var value = await showDialog(
              context: context,
              barrierDismissible: false,
              barrierColor: Colors.purpleAccent.withOpacity(0.1),
              builder: (ct) => AlertDialog(
                    title: Text('Reset'),
                    content: Text(
                        'Are you sure you want to reset the phone? All data will be removed'),
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
                    ],
                  ));
          setState(() {
            message = value;
          });
        },
        child: Icon(Icons.slideshow),
      ),
    );
  }
}
