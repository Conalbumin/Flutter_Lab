import 'package:flutter/material.dart';
import 'NoteListScreen.dart';
import 'EditScreen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isListView = true; // Track the current view mode

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
            // Change icon based on view mode
            icon: isListView ? const Icon(Icons.grid_view) : const Icon(
                Icons.list),
            onPressed: () {
              // Call method to toggle view mode
              setState(() {
                isListView = !isListView;
              });
            },
          ),
        ],
      ),
      body: isListView ? _buildListView() : _buildGridView(),
      // Choose ListView or GridView based on view mode
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var editedNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (
                ct) => const EditScreen()), // Pass null or create a new note object to indicate creating a new note
          );
          if (editedNote != null) {
            setState(() {
                // Add the edited note to the list if it doesn't exist
                notes.add(editedNote);
                print('editedNote add ${editedNote}');
            });
          }
        },
      ),);
  }

  Widget _buildListView() {
    return ListView(
      children: notes.map((e) => _buildNoteTileForListView(e)).toList(),
    );
  }

  Widget _buildGridView() {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: notes.map((e) => _buildNoteTileForGridview(e))
            .toList(), // Use a method to build tiles without the newspaper icon
      ),
    );
  }

  Widget _buildNoteTileForGridview(Map<String, Object> note) {
    return Card(
      child: InkWell(
        onTap: () async {
          final editedNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => EditScreen(note: note)),
          );

          if (editedNote != null) {
            setState(() {
              // Find the index of the edited note in the notes list
              final index = notes.indexWhere((element) =>
              element['id'] == editedNote['id']);
              if (index != -1) {
                // Update the note in the list
                notes[index] = editedNote;
              }
            });
          }
        },
        child: Container(
          color: Colors.yellow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                note['title'] as String,
                style: const TextStyle(color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Text(
                note['content'] as String,
                style: const TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteTileForListView(Map<String, Object> note) {
    return ListTile(
      onTap: () async {
        final editedNote = await Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => EditScreen(note: note)),
        );

        if (editedNote != null) {
          setState(() {
            // Find the index of the edited note in the notes list
            final index = notes.indexWhere((element) =>
            element['id'] == editedNote['id']);
            if (index != -1) {
              // Update the note in the list
              notes[index] = editedNote;
            }
          });
        }
      },
      leading: const Icon(Icons.newspaper),
      title: Text(
        note['title'] as String,
        style: const TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(
        note['content'] as String,
        style: const TextStyle(fontSize: 15),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
