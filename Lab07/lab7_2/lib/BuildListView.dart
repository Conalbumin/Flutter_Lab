import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BuildListView extends StatelessWidget {
  final List<Map<String, Object>> notes;
  final Function(Map<String, Object>) onNoteTap;
  bool isProtected = false;

  BuildListView({
    required this.notes,
    required this.onNoteTap,
  });


  Widget _buildNoteTileForListView(Map<String, Object> note) {
    bool isProtected = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                label: 'Delete',
                onPressed: (context) {},
                icon: Icons.delete,
                backgroundColor: Colors.red,
              ),
              if(isProtected)
                SlidableAction(
                  label: 'Change password',
                  onPressed: (context) {
                  },
                  icon: Icons.change_circle,
                  backgroundColor: Colors.blue,
                ),
              if(isProtected)
                SlidableAction(
                  label: 'Unlock',
                  onPressed: (context) {
                    setState(() {
                      isProtected = !isProtected;
                    });
                  },
                  icon: Icons.lock_open,
                  backgroundColor: Colors.orange,
                ),
              if(!isProtected)
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
            trailing: isProtected ? const Icon(Icons.lock) : null,
          ),
        );
      },
    );  }

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


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: notes.map((e) => _buildNoteTileForListView(e)).toList(),
    );
  }
}
