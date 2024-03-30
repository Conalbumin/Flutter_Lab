import 'package:flutter/material.dart';

class BottomSheetCustom extends StatefulWidget {
  const BottomSheetCustom({super.key});

  @override
  State<BottomSheetCustom> createState() => _BottomSheetCustomState();
}

class _BottomSheetCustomState extends State<BottomSheetCustom> {
  String selected = "Vietnam";

  var items = ['Vietnam', 'Laos', 'Cambodia', 'Thailand'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        backgroundColor: Colors.blue,
        title: Text("BottomSheetCustom Dialog"),
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
          showModalBottomSheet(
              context: context,
              builder: (ctx) =>
                  Wrap(
                    children: items.map((e) =>
                        ListTile(
                          onTap: () {
                            setState(() {
                              selected = e;
                              Navigator.pop(context);
                            });
                          },
                            title: Text(e),
                            trailing: (e == selected) ? Icon(Icons.check) : null
                        )
                    )
                        .toList(),
                  ));
        },
      ),
    );
  }
}
