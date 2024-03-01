import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BuildListView extends StatefulWidget {
  final List<Map<String, Object>> notes;
  final Function(Map<String, Object>) onNoteTap;
  final Function(Map<String, Object>) onDeleteNote;
  final Function() onUpdateNotes;
  final Function(Map<String, Object>) onRestoreNote;
  final bool isProtected;

  BuildListView({
    required this.notes,
    required this.onNoteTap,
    required this.onDeleteNote,
    required this.onUpdateNotes,
    required this.onRestoreNote,
    required this.isProtected
  });

  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController enterPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isProtected = false;
  bool isNoteProtected = false;

  Widget _buildNoteTileForListView(Map<String, Object> note) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                label: 'Delete',
                onPressed: (context) {
                  _showDeleteConfirmationDialog(context, note);
                },
                icon: Icons.delete,
                backgroundColor: Colors.red,
              ),
              if (note['isProtected'] == true)
                SlidableAction(
                  label: 'Change password',
                  onPressed: (context) {},
                  icon: Icons.change_circle,
                  backgroundColor: Colors.blue,
                ),
              if (note['isProtected'] == true)
                SlidableAction(
                  label: 'Unlock',
                  onPressed: (context) {
                    setState(() {
                      _showDialogAskPassword(context, note);
                    });
                  },
                  icon: Icons.lock_open,
                  backgroundColor: Colors.orange,
                ),
              if (note['isProtected'] == false)
                SlidableAction(
                  label: 'Protect',
                  onPressed: (context) {
                    _showDialogSetPassword(context, note);
                  },
                  icon: Icons.lock,
                  backgroundColor: Colors.teal,
                )
            ],
          ),
          child: ListTile(
            onTap: () async {
              widget.onNoteTap(note);
            },
            leading: const Icon(Icons.newspaper),
            title: Text(
              note['title'] as String,
              style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            subtitle: Text(
              note['content'] as String,
              style: const TextStyle(fontSize: 15),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: note['isProtected'] == true ? const Icon(Icons.lock) : null,
          ),
        );
      },
    );
  }

  void _showDialogSetPassword(BuildContext context, Map<String, Object> note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Set Password"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle confirm action here
                    String password = passwordController.text;
                    String confirmPassword = confirmPasswordController.text;

                    // Check if passwords match
                    if (password == confirmPassword) {
                      // Passwords match, protect the note
                      setState(() {
                        note['isProtected'] = true;
                      });
                      Navigator.of(context).pop();
                      widget.onUpdateNotes();
                    } else {
                      print('Passwords do not match');
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDialogAskPassword(BuildContext context, Map<String, Object> note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Password"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: enterPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Enter your password',
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle confirm action here
                    String enterPassword = enterPasswordController.text;
                    String password = passwordController.text;
                    print(enterPassword);
                    print(password);
                    // Check if passwords match
                    if (enterPassword == password) {
                      setState(() {
                        note['isProtected'] = false;
                      });
                      Navigator.of(context).pop();
                      widget.onUpdateNotes();
                    } else {
                      print('Passwords do not match');
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Map<String, Object> note) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete note"),
          content: const Text("Are you sure you want to delete this note?"),
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
                widget.onDeleteNote(note);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Note deleted'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        widget.onRestoreNote(note);
                      },
                    ),
                  ),
                );
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.notes.map((e) => _buildNoteTileForListView(e)).toList(),
    );
  }
}
