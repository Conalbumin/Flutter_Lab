import 'package:flutter/material.dart';
import 'BuildGridView.dart';
import 'BuildListView.dart';

class Home extends StatefulWidget {
  final List<Map<String, Object>> notes;
  final Function(Map<String, Object>) onNoteTap;
  final Function(Map<String, Object>) onDeleteNote;
  final bool isListView; // Add isListView as a parameter
  final Function() onUpdateNotes;

  Home({
    required this.notes,
    required this.onNoteTap,
    required this.onDeleteNote,
    required this.onUpdateNotes,
    required this.isListView,
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
        body: widget.isListView // Use isListView from the widget instance
            ? _buildListView(widget.notes, widget.onNoteTap, widget.onDeleteNote, widget.onUpdateNotes)
            : _buildGridView(widget.notes, widget.onNoteTap, widget.onDeleteNote, widget.onUpdateNotes),
      ),
    );
  }

  Widget _buildListView(List<Map<String, Object>> notes, Function(Map<String, Object>) onNoteTap,
      Function(Map<String, Object>) onDeleteNote, Function() onUpdateNotes) {
    return BuildListView(notes: notes, onNoteTap: onNoteTap, onDeleteNote: onDeleteNote, onUpdateNotes: onUpdateNotes);
  }

  Widget _buildGridView(List<Map<String, Object>> notes, Function(Map<String, Object>) onNoteTap,
      Function(Map<String, Object>) onDeleteNote, Function() onUpdateNotes) {
    return BuildGridView(notes: notes, onNoteTap: onNoteTap, onDeleteNote: onDeleteNote, onUpdateNotes: onUpdateNotes);
  }
}
