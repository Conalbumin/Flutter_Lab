import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive GridView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveGridView(),
    );
  }
}

class ResponsiveGridView extends StatefulWidget {
  @override
  _ResponsiveGridViewState createState() => _ResponsiveGridViewState();
}

class _ResponsiveGridViewState extends State<ResponsiveGridView> {
  int _crossAxisCount = 1;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive GridView'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth >= 800) {
            _crossAxisCount = 4;
            _color = Colors.red;
          } else if (constraints.maxWidth >= 400) {
            _crossAxisCount = 3;
            _color = Colors.green;
          } else if (constraints.maxWidth >= 200) {
            _crossAxisCount = 2;
            _color = Colors.yellow;
          } else {
            _crossAxisCount = 1;
            _color = Colors.blue;
          }

          // Calculate itemCount based on _crossAxisCount
          int itemCount = (_crossAxisCount == 1)
              ? 6
              : (_crossAxisCount == 2)
              ? 14
              : (_crossAxisCount == 3)
              ? 15
              : 12;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount,
            ),
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(5),
                color: _color,
                child: Center(
                  child: Text(
                    'Item ${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
