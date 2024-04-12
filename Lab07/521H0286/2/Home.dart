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
  final bool isProtected;

  Home({
    required this.notes,
    required this.onNoteTap,
    required this.onDeleteNote,
    required this.onUpdateNotes,
    required this.isListView,
    required this.onRestoreNote,
    required this.isProtected,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: widget.isListView
            ? _buildListView(widget.notes, widget.onNoteTap, widget.onDeleteNote, widget.onUpdateNotes, widget.onRestoreNote, widget.isProtected)
            : _buildGridView(widget.notes, widget.onNoteTap, widget.onDeleteNote, widget.onUpdateNotes, widget.onRestoreNote, widget.isProtected),
      ),
    );
  }

  Widget _buildListView(List<Map<String, Object>> notes, Function(Map<String, Object>) onNoteTap,
      Function(Map<String, Object>) onDeleteNote, Function() onUpdateNotes, Function(Map<String, Object>) onRestoreNote, bool isProtected) {
    return BuildListView(notes: notes, onNoteTap: onNoteTap, onDeleteNote: onDeleteNote, onUpdateNotes: onUpdateNotes, onRestoreNote: onRestoreNote, isProtected: isProtected);
  }

  Widget _buildGridView(List<Map<String, Object>> notes, Function(Map<String, Object>) onNoteTap,
      Function(Map<String, Object>) onDeleteNote, Function() onUpdateNotes, Function(Map<String, Object>) onRestoreNote, bool isProtected) {
    return BuildGridView(notes: notes, onNoteTap: onNoteTap, onDeleteNote: onDeleteNote, onUpdateNotes: onUpdateNotes, onRestoreNote: onRestoreNote, isProtected: isProtected);
  }
}
