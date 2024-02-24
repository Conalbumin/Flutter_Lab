import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatefulWidget {
  final List<Map<String, Object>> notes;
  final Function(Map<String, Object>) onNoteTap;

  Home({
    required this.notes,
    required this.onNoteTap,
  });

  @override
  State<Home> createState() => HomeState(notes: notes, onNoteTap: onNoteTap);

  Widget buildListView(List<Map<String, Object>> notes, Function(Map<String, Object>) onNoteTap) {
    return HomeState(notes: notes, onNoteTap: onNoteTap).buildListView();
  }

  Widget buildGridView(List<Map<String, Object>> notes, Function(Map<String, Object>) onNoteTap) {
    return HomeState(notes: notes, onNoteTap: onNoteTap).buildGridView();
  }
}

class HomeState extends State<Home> {
  final List<Map<String, Object>> notes;
  final Function(Map<String, Object>) onNoteTap;

  HomeState({
    required this.notes,
    required this.onNoteTap,
  });

  Widget buildListView() {
    return ListView(
      children: notes.map((e) => _buildNoteTileForListView(e)).toList(),
    );
  }

  Widget _buildNoteTileForListView(Map<String, Object> note) {
    bool isProtected = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                label: 'Delete',
                onPressed: (context) {},
                icon: Icons.delete,
                backgroundColor: Colors.red,
              ),
              if(isProtected)
                SlidableAction(
                  label: 'Change password',
                  onPressed: (context) {},
                  icon: Icons.change_circle,
                  backgroundColor: Colors.blue,
                ),
              if(isProtected)
                SlidableAction(
                  label: 'Unlock',
                  onPressed: (context) {
                    setState(() {
                      isProtected = !isProtected;
                    });
                  },
                  icon: Icons.lock_open,
                  backgroundColor: Colors.orange,
                ),
              if(!isProtected)
                SlidableAction(
                  label: 'Protect',
                  onPressed: (context) {
                    setState(() {
                      isProtected = !isProtected;
                    });
                  },
                  icon: Icons.lock,
                  backgroundColor: Colors.teal,
                )
            ],
          ),
          child: ListTile(
            onTap: () async {
              onNoteTap(note);
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
            trailing: isProtected ? const Icon(Icons.lock) : null,
          ),
        );
      },
    );  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      children: notes.map((e) => _buildNoteTileForGridView(e)).toList(),
    );
  }

  Widget _buildNoteTileForGridView(Map<String, Object> note) {
    return Builder(
      builder: (context) => GestureDetector(
        onLongPress: () {
          print("Long press detected");
          _showNoteOptionsBottomSheet(context, note);
        },
        child: Card(
          child: InkWell(
            onTap: () async {
              onNoteTap(note);
            },
            child: Container(
              color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    note['title'] as String,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
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
        ),
      ),
    );
  }

  void _showNoteOptionsBottomSheet(BuildContext context, Map<String, Object> note) {
    bool isProtected = false;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildOptionRow(Icons.delete, "Delete this note", () {
                      Navigator.of(context).pop();
                      // Handle delete action here
                    }),
                    const Divider(), // Divider between rows
                    if (!isProtected) // If note is not protected
                      _buildOptionRow(Icons.lock, "Protect this note", () {
                        setState(() {
                          isProtected = true;
                        });
                      }),
                    if (isProtected) // If note is protected
                      _buildOptionRow(Icons.change_circle, "Change password", () {
                        // Handle change password action here
                      }),
                    const Divider(), // Divider between rows

                    if (isProtected) // If note is protected
                      _buildOptionRow(Icons.lock_open, "Remove password", () {
                        setState(() {
                          isProtected = false;
                        });
                      }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  Widget _buildOptionRow(IconData icon, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        child: Row(
          children: [
            const SizedBox(width: 20),
            Icon(icon),
            const SizedBox(width: 20),
            Text(text, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder, modify as needed
  }
}
