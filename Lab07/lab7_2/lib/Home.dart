import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatelessWidget {
  final List<Map<String, Object>> notes;
  final Function(Map<String, Object>) onNoteTap;

  Home({
    required this.notes,
    required this.onNoteTap,
  });

  Widget buildListView() {
    return ListView(
      children: notes.map((e) => buildNoteTileForListView(e)).toList(),
    );
  }

  Widget buildNoteTileForListView(Map<String, Object> note) {
    bool isProtected = false;

    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            onPressed: (context) {},
            icon: Icons.delete,
            backgroundColor: Colors.red,
          ),
          SlidableAction(
            label: isProtected ? 'Unlock' : 'Protect',
            onPressed: (context) {
              if (isProtected) {
                // Handle unlock action
              } else {
                // Handle protect action
              }
              isProtected = !isProtected;
            },
            icon: isProtected ? Icons.lock_open : Icons.lock,
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
      ),
    );
  }

  Widget buildGridView() {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: notes.map((e) => buildNoteTileForGridview(e)).toList(),
      ),
    );
  }

  Widget buildNoteTileForGridview(Map<String, Object> note) {
    return Card(
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

  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder, modify as needed
  }
}
