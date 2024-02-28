import 'package:flutter/material.dart';
import 'BuildGridView.dart';
import 'BuildListView.dart';

class Home extends StatefulWidget {
  final List<Map<String, Object>> notes;
  final Function(Map<String, Object>) onNoteTap;
  final bool isListView; // Add isListView as a parameter

  Home({
    required this.notes,
    required this.onNoteTap,
    required this.isListView, // Add isListView to the constructor
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isProtected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          // Your app bar content
        ),
        body: widget.isListView // Use isListView from the widget instance
            ? _buildListView(widget.notes, widget.onNoteTap)
            : _buildGridView(widget.notes, widget.onNoteTap),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildListView(List<Map<String, Object>> notes, Function(Map<String, Object>) onNoteTap) {
    return BuildListView(notes: notes, onNoteTap: onNoteTap);
  }

  Widget _buildGridView(List<Map<String, Object>> notes, Function(Map<String, Object>) onNoteTap) {
    return BuildGridView(notes: notes, onNoteTap: onNoteTap);
  }
}
