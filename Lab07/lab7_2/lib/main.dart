import 'package:flutter/material.dart';
import 'Home.dart';
import 'NoteListScreen.dart';
import 'EditScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isListView = true;
  bool isProtected = false;

  // Function to restore a deleted note
  void onRestoreNote(Map<String, Object> note) {
    setState(() {
      notes.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Note Management',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: isListView
                ? const Icon(Icons.grid_view)
                : const Icon(Icons.list),
            onPressed: () {
              setState(() {
                isListView = !isListView;
              });
            },
          ),
        ],
      ),
      body: Home(
        notes: notes,
        onNoteTap: (note) {
          // Handle note tap
        },
        onDeleteNote: (note) {
          setState(() {
            notes.remove(note);
          });
        },
        onUpdateNotes: () {
          setState(() {});
        },
        isProtected: isProtected,
        onRestoreNote: onRestoreNote,
        isListView: isListView, // Pass isListView to Home widget
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var editedNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (ct) => const EditScreen()),
          );
          if (editedNote != null) {
            setState(() {
              notes.add(editedNote);
              print('editedNote add ${editedNote}');
            });
          }
        },
      ),
    );
  }
}
