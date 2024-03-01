import 'package:flutter/material.dart';
import 'users.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Widget _objToUser(context, idx) {
    var obj = users[idx];
    String title = obj['fullName'];
    String subtitle = obj['jobTitle'];
    bool favorited = obj['favorited'] ?? false;
    bool block = obj['block'] ?? false;

    return AnimatedOpacity(
      opacity: block ? 0.5 : 1.0,
      duration: Duration(milliseconds: 300),
      child: ListTile(
        leading: CircleAvatar(
          radius: 36,
          backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/men/${idx + 1}.jpg'),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            favorited ? Icon(Icons.favorite) : Icon(null),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.favorite),
                    title: Text(
                        favorited ? 'Remove from favorite' : 'Add to favorite'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        obj['favorited'] = !favorited;
                      });
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.block),
                    title: Text(block ? 'Unlock this user' : 'Block this user'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        obj['block'] = !block;
                      });
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Delete this user'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        users.removeAt(idx);
                      });
                    },
                  ),
                )
              ],
            ),
          ],
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('You have clicked on user ${title}'),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {},
            ),
          ));
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(
            child: Text('Listview', style: TextStyle(color: Colors.white)),
          ),
        ),
        body: ListView.separated(
          // cach 3
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            color: Colors.grey,
          ),
          itemBuilder: ((context, index) => _objToUser(context, index)),
          itemCount: users.length,
        ));
  }
}
