import 'package:flutter/material.dart';

class BuildGridView extends StatelessWidget {
  final List<Map<String, Object>> notes;
  final Function(Map<String, Object>) onNoteTap;
  bool isProtected = false;

  BuildGridView({
    required this.notes,
    required this.onNoteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: notes.map((e) => _buildNoteTileForGridView(e)).toList(),
    );
  }

  Widget _buildNoteTileForGridView(Map<String, Object> note) {
    bool isProtected = false;

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
          if (isProtected)
            Positioned(
              top: 5,
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
                      // Handle delete action here
                    }),
                    const Divider(), // Divider between rows
                    if (!this.isProtected) // If note is not protected
                      buildOptionBottomSheet(Icons.lock, "Protect this note", () {
                        // Call _showDialogSetPassword when Protect is tapped
                        _showDialogSetPassword(context, note);
                      }),
                    if (this.isProtected) // If note is protected
                      buildOptionBottomSheet(Icons.change_circle, "Change password", () {
                        // Handle change password action here
                      }),
                    const Divider(), // Divider between rows

                    if (this.isProtected) // If note is protected
                      buildOptionBottomSheet(Icons.lock_open, "Remove password", () {
                        setState(() {
                          this.isProtected = false;
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

}
