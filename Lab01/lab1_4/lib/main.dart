import 'package:flutter/material.dart';
import 'package:units_converter/units_converter.dart';

void main() {
  runApp(
      MaterialApp(home: MyApp(),),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String value = 'Hexadecimal';

  void _handleTextChange(newValue) {
    setState(() {
      this.value = newValue;
    });
    print('new value: $newValue');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Package Example'), backgroundColor: Colors.blue,),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: _handleTextChange,
              decoration: InputDecoration(
                label: Text('Decimal Number'),
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              value.trim().length == 0 ? 'Hexadecimal' : value.convertFromTo(NUMERAL_SYSTEMS.decimal, NUMERAL_SYSTEMS.hexadecimal).toString(),
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

}
