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

    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            icon: Icons.lock,
          ),
          SlidableAction(
            label: 'Delete',
            onPressed: (context) {},
            icon: Icons.delete,
            backgroundColor: Colors.red,
          ),
          SlidableAction(
            label: 'Protect',
            onPressed: (context) {
              if (isProtected) {
              } else {
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
    return GridView.count(
      crossAxisCount: 2,
      children: notes.map((e) => _buildNoteTileForGridView(e)).toList(),
    );
  }

  Widget _buildNoteTileForGridView(Map<String, Object> note) {
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
