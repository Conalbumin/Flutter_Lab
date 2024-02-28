import 'package:flutter/material.dart';
import 'BuildGridView.dart';
import 'BuildListView.dart';

class Home extends StatefulWidget {
  final List<Map<String, Object>> notes;
  final Function(Map<String, Object>) onNoteTap;
  final Function(Map<String, Object>) onDeleteNote;
  final bool isListView;
  final Function() onUpdateNotes;
  final Function(Map<String, Object>) onRestoreNote;

  Home({
    required this.notes,
    required this.onNoteTap,
    required this.onDeleteNote,
    required this.onUpdateNotes,
    required this.isListView,
    required this.onRestoreNote,
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
            ? _buildListView(widget.notes, widget.onNoteTap, widget.onDeleteNote, widget.onUpdateNotes, widget.onRestoreNote)
            : _buildGridView(widget.notes, widget.onNoteTap, widget.onDeleteNote, widget.onUpdateNotes, widget.onRestoreNote),
      ),
    );
  }

  Widget _buildListView(List<Map<String, Object>> notes, Function(Map<String, Object>) onNoteTap,
      Function(Map<String, Object>) onDeleteNote, Function() onUpdateNotes, Function(Map<String, Object>) onRestoreNote) {
    return BuildListView(notes: notes, onNoteTap: onNoteTap, onDeleteNote: onDeleteNote, onUpdateNotes: onUpdateNotes, onRestoreNote: onRestoreNote);
  }

  Widget _buildGridView(List<Map<String, Object>> notes, Function(Map<String, Object>) onNoteTap,
      Function(Map<String, Object>) onDeleteNote, Function() onUpdateNotes, Function(Map<String, Object>) onRestoreNote) {
    return BuildGridView(notes: notes, onNoteTap: onNoteTap, onDeleteNote: onDeleteNote, onUpdateNotes: onUpdateNotes, onRestoreNote: onRestoreNote);
  }
}
