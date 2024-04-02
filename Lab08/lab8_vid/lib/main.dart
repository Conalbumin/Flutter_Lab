import 'package:flutter/material.dart';
import 'alert_dialog.dart';
import 'custom_dialog.dart';
import 'bottom_sheet.dart';
import 'date_picker.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Simple(),
  ));
}

class Simple extends StatefulWidget {
  const Simple({super.key});

  @override
  State<Simple> createState() => _SimpleState();
}

class _SimpleState extends State<Simple> {
  String message = "dw";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        backgroundColor: Colors.blue,
        title: Text("Simple Dialog"),
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
              builder: (ct) => SimpleDialog(
                    title: Text('Simple Dialog'),
                    children: [
                      SimpleDialogOption(
                        child: Text("Vietnam"),
                        onPressed: () {
                          Navigator.pop(context, "Vietnam");
                        },
                      ),
                      SimpleDialogOption(
                        child: Text("England"),
                        onPressed: () {
                          Navigator.pop(context, "England");
                        },
                      ),
                      SimpleDialogOption(
                        child: Text("Japan"),
                        onPressed: () {
                          Navigator.pop(context, "Japan");
                        },
                      ),
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
