import 'package:flutter/material.dart';
import 'NoteListScreen.dart';

class EditScreen extends StatefulWidget {
  final Map<String, Object>? note;

  const EditScreen({this.note, Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>(); // Key for scaffold

  late FocusNode _focus;
  String _title = '';
  String _content = '';

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final newNote = {
        'id': widget.note?['id'] ?? UniqueKey().toString(),
        'title': _title,
        'content': _content
      }; // Ensure each note has an ID

      // Show confirmation dialog
      _showConfirmationEditDialog(context, newNote);
    } else {
      _focus.requestFocus();
    }
  }


  void _showSnackbar(String message) {
    ScaffoldMessengerState? scaffoldState = ScaffoldMessenger.maybeOf(context);
    if (scaffoldState != null) {
      scaffoldState.showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2), // Optional: Customize duration
        ),
      );
    } else {
      // Handle the case where the `ScaffoldMessenger` is not available
      print('Unable to show snackbar: ScaffoldMessenger not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text(
          widget.note != null ? 'Edit a Note' : 'Create New Note',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: widget.note?['title'] as String? ?? '',
                  focusNode: _focus,
                  onSaved: (value) {
                    _title = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.note?['content'] as String? ?? '',
                  onSaved: (value) {
                    _content = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your content';
                    }
                    if (value.length < 10) return 'Too short';
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
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Save Note',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationEditDialog(BuildContext context, Map<String, Object> note) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Save changes"),
          content: const Text("Note is modified, do you want to continue editing?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Save changed'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                      },
                    ),
                  ),
                );
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

}
