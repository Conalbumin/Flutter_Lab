import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'add_new_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

import 'api_service.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  Future<void> fetchUsers() async {
    try {
      List<Map<String, dynamic>> data = await ApiService.getUsers();
      setState(() {
        users = data;
      });
    } catch (e) {
      print('Error fetching users: $e');
      // Handle error as needed
    }
  }

  void addUser(Map<String, dynamic> user) async {
    try {
      Map<String, dynamic> addedUser = await ApiService.addUser(user);
      setState(() {
        users.add(addedUser);
      });
    } catch (e) {
      print('Error adding user: $e');
      // Handle error as needed
    }
  }

  void updateUser(String id, Map<String, dynamic> user) async {
    try {
      await ApiService.updateUser(id, user);
      fetchUsers(); // Refresh the user list
    } catch (e) {
      print('Error updating user: $e');
      // Handle error as needed
    }
  }

  void deleteUser(String id) async {
    try {
      await ApiService.deleteUser(id);
      setState(() {
        users.removeWhere((user) => user['id'] == id);
      });
    } catch (e) {
      print('Error deleting user: $e');
      // Handle error as needed
    }
  }

  Widget _userToListItem(ct, idx) {
    Map<String, dynamic> user = users[idx];
    return ListTile(
      enabled: !user['blocked'],
      leading: CircleAvatar(
        radius: 32,
        backgroundImage: CachedNetworkImageProvider(user['img']),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            user['favorited'] ? Icons.favorite : null,
            color: Colors.pink,
          ),
          PopupMenuButton(
            padding: EdgeInsets.zero,
            itemBuilder: ((context) => [
              PopupMenuItem(
                padding: EdgeInsets.zero,
                child: ListTile(
                  title: Text(user['favorited']
                      ? 'Remove from favorite'
                      : 'Add to favorite'),
                  leading: const Icon(Icons.favorite),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      user['favorited'] = !user['favorited'];
                    });
                  },
                ),
              ),
              PopupMenuItem(
                padding: EdgeInsets.zero,
                child: ListTile(
                  title: Text(user['blocked']
                      ? 'Unblock this user'
                      : 'Block this user'),
                  leading: const Icon(Icons.block),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      user['blocked'] = !user['blocked'];
                    });
                  },
                ),
              ),
              PopupMenuItem(
                padding: EdgeInsets.zero,
                child: ListTile(
                  title: const Text('Delete this user'),
                  leading: const Icon(Icons.delete),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      users.removeAt(idx);
                    });
                  },
                ),
              )
            ]),
          )
        ],
      ),
      title: Text(user['fullName']!),
      subtitle: Text(user['jobTitle']!),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You've clicked on ${users[idx]['fullName']}"),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () => {},
              textColor: Colors.amber,
            ),
          ),
        );
      },
    );
  }

  void _addNewUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => AddUserScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Consume REST API', style: TextStyle(color: Colors.white),),
        actions: [IconButton(onPressed: _addNewUser, icon: Icon(Icons.add, color: Colors.white,))],
      ),
      body: ListView.separated(
          itemBuilder: _userToListItem,
          separatorBuilder: (ct, idx) => const Divider(
            height: 1,
          ),
          itemCount: users.length),
    );
  }
}
