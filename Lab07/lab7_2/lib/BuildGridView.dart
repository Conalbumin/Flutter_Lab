import 'package:flutter/material.dart';

import 'EditScreen.dart';

class BuildGridView extends StatefulWidget {
  final List<Map<String, Object>> notes;
  final Function(Map<String, Object>) onNoteTap;
  final Function(Map<String, Object>) onDeleteNote;
  final Function() onUpdateNotes;
  final Function(Map<String, Object>) onRestoreNote;
  final bool isProtected;

  BuildGridView({
    required this.notes,
    required this.onNoteTap,
    required this.onDeleteNote,
    required this.onUpdateNotes,
    required this.onRestoreNote,
    required this.isProtected
  });

  @override
  State<BuildGridView> createState() => _BuildGridViewState();
}

class _BuildGridViewState extends State<BuildGridView> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController enterPasswordControllerinUnlock = TextEditingController();
  TextEditingController enterPasswordControllerinChange = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController confirmPasswordControllerinChange = TextEditingController();
  bool isProtected = false;
  bool isNoteProtected = false;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: widget.notes.map((e) => _buildNoteTileForGridView(e)).toList(),
    );
  }

  Widget _buildNoteTileForGridView(Map<String, Object> note) {
    return Builder(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onLongPress: () {
              print("Long press detected");
              _showNoteOptionsBottomSheet(context, note);
            },
            child: Card(
              child: InkWell(
                onTap: () async {
                  if (note['isProtected'] == true) {
                    // Note is locked, show a message or take other action to inform the user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Note is locked'),
                      ),
                    );
                  } else {
                    // Note is not locked, allow navigation
                    final editedNote = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) => EditScreen(note: note)),
                    );
                    widget.onNoteTap(note);
                  }
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
          if (note['isProtected'] == true) // Check if the note is protected
            const Positioned(
              left: 5,
              child: Icon(Icons.lock, color: Colors.black),
            ),
        ],
      ),
    );
  }

  void _showNoteOptionsBottomSheet(BuildContext context, Map<String, Object> note) {
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
                    buildOptionBottomSheet(Icons.delete, "Delete this note", () {
                      Navigator.of(context).pop();
                      _showDeleteConfirmationDialog(context, note);
                    }),
                    const Divider(),
                    if (note['isProtected'] == false)
                      buildOptionBottomSheet(Icons.lock, "Protect this note", () {
                        setState(() {
                          _showDialogSetPassword(context,note);
                        });
                      }),
                    if (note['isProtected'] == true)
                      buildOptionBottomSheet(Icons.change_circle, "Change password", () {
                        setState(() {
                          _showDialogChangePassword(context,note);
                        });
                      }),
                    const Divider(),

                    if (note['isProtected'] == true)
                      buildOptionBottomSheet(Icons.lock_open, "Remove password", () {
                        setState(() {
                          _showDialogAskPassword(context,note);
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

  Widget buildOptionBottomSheet(IconData icon, String text, VoidCallback onTap) {
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

  void _showDialogSetPassword(BuildContext context, Map<String, Object> note){
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

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
                        this.isProtected = true;
                      });
                      Navigator.of(context).pop();
                    } else {
                      // Passwords don't match, show error message or handle accordingly
                      print('Passwords do not match');
                      // Show error message or handle accordingly
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
                    controller: enterPasswordControllerinUnlock,
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
                    String enterPassword = enterPasswordControllerinUnlock.text;
                    String password = passwordController.text;
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

  void _showDialogChangePassword(BuildContext context, Map<String, Object> note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Change Password"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: enterPasswordControllerinChange,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Old Password',
                    ),
                  ),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                    ),
                  ),
                  TextField(
                    controller: confirmPasswordControllerinChange,
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
                    String enterPassword = enterPasswordControllerinChange.text;
                    String oldPassword = passwordController.text;
                    String newPassword = newPasswordController.text;
                    String confirmPassword = confirmPasswordControllerinChange.text;

                    // Passwords match, protect the note
                    print("enterPassword $enterPassword");
                    print("oldPassword $oldPassword");
                    print("newPassword $newPassword");
                    print("confirmPassword $confirmPassword");
                    // Check if passwords match
                    if (enterPassword == oldPassword) {
                      if (newPassword == confirmPassword) {
                        setState(() {
                          passwordController.text = newPassword; // Update password here
                        });
                        print("oldPassword updated: ${passwordController.text}");
                      }
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
                // Call onDeleteNote callback to delete the note
                widget.onDeleteNote(note);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Note deleted'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Restore the deleted note
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
}
