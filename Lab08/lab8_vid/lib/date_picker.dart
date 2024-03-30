import 'package:flutter/material.dart';

class Date_Picker extends StatefulWidget {
  const Date_Picker({super.key});

  @override
  State<Date_Picker> createState() => _Date_PickerState();
}

class _Date_PickerState extends State<Date_Picker> {
  String selected = "Vietnam";

  var items = ['Vietnam', 'Laos', 'Cambodia', 'Thailand'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        backgroundColor: Colors.blue,
        title: Text("Date_Picker Dialog"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Text(
          selected,
          style: TextStyle(fontSize: 50),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.slideshow),
        onPressed: () async {
          var value = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2024, 3,3),
              lastDate: DateTime(2024, 3,12));
          print(value);
        },
      ),
    );
  }
}
