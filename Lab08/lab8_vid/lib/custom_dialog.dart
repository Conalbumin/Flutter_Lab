import 'package:flutter/material.dart';

class Custom extends StatefulWidget {
  const Custom({super.key});

  @override
  State<Custom> createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  String selected = "Vietnam";

  var items = ['Vietnam', 'Laos', 'Cambodia', 'Thailand'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        backgroundColor: Colors.blue,
        title: Text("Custom Dialog"),
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
          showDialog(
              context: context,
              builder: (ctx) => StatefulBuilder(
                builder: (ctx, setStateIn) => AlertDialog(
                      title: Text('Choose your country'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: items
                            .map((e) => RadioListTile(
                          title: Text(e),
                                value: e,
                                groupValue: selected,
                                onChanged: (v) => {
                                  setState(() {
                                    setStateIn(() {
                                      selected = v!;
                                    });
                                  })
                                }))
                            .toList(),
                      ),
                    ),
              ));
        },
      ),
    );
  }
}
