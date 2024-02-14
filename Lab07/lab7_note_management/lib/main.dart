import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var noteList = [
    {'id': 1, 'title': 'Đi chợ', 'message': 'Mua rau, thịt, cá'},
    {'id': 2, 'title': 'Đi chơi', 'message': 'Gắp thú, bánh kẹo'},
    {'id': 3, 'title': 'Deadline', 'message': '2/9/2024'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: ListView(
            children: noteList
                .map((e) => ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => EditScreen(note: e)));
                      },
                      leading: const Icon(Icons.list),
                      title: Text(e['title'] as String),
                      subtitle: Text(e['message'] as String),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ))
                .toList()),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var note = await Navigator.push(
              context, MaterialPageRoute(builder: (ct) => EditScreen()));
          if (note != null) {
            setState(() {
              noteList.add(note);
            });
          }
        },
      ),
    );
  }
}

class EditScreen extends StatefulWidget {
  var note;

  EditScreen({this.note, super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var _key = GlobalKey<FormState>();
  var focus = FocusNode();
  String title = '';
  String message = '';

  void _saveForm() {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState?.save();
      Navigator.pop(context, {'title': title, 'message': message});
    } else {
      focus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.note != null ? 'Edit Note' : 'New Note',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _key,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: widget.note != null ? widget.note['title'] : '',
                  focusNode: focus,
                  onSaved: (v) {
                    title = v ?? '';
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please enter your title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Title'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.note != null ? widget.note['message'] : '',
                  onSaved: (v) {
                    message = v ?? '';
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please enter your content';
                    }
                    if (v.length < 10) return 'Too short';
                    return null;
                  },
                  maxLines: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Content',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      _saveForm();
                    },
                    child: const Icon(Icons.save))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
