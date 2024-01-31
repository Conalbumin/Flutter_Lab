import 'package:flutter/material.dart';

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
  List<Map<String, dynamic>> users = [
    {"id": 1, "fullName": "John Doe", "jobTitle": "Software Engineer"},
    {"id": 2, "fullName": "Jane Smith", "jobTitle": "Product Manager"},
    {"id": 3, "fullName": "Michael Johnson", "jobTitle": "UX Designer"},
    {"id": 4, "fullName": "Sarah Lee", "jobTitle": "Data Scientist"},
    {"id": 5, "fullName": "David Brown", "jobTitle": "DevOps Engineer"},
    {
      "id": 6,
      "fullName": "Emily Davis",
      "jobTitle": "Quality Assurance Analyst"
    },
    {"id": 7, "fullName": "William Garcia", "jobTitle": "Front-end Developer"},
    {"id": 8, "fullName": "Ashley Rodriguez", "jobTitle": "Business Analyst"},
    {"id": 9, "fullName": "Matthew Wilson", "jobTitle": "Full-stack Developer"},
    {"id": 10, "fullName": "Olivia Taylor", "jobTitle": "Project Manager"},
    {
      "id": 11,
      "fullName": "James Anderson",
      "jobTitle": "Database Administrator"
    },
    {"id": 12, "fullName": "Isabella Thomas", "jobTitle": "Data Analyst"},
    {"id": 13, "fullName": "Alexander Jackson", "jobTitle": "Mobile Developer"},
    {"id": 14, "fullName": "Ava Miller", "jobTitle": "Quality Engineer"},
    {"id": 15, "fullName": "Ethan Davis", "jobTitle": "Systems Administrator"}
  ];

  Widget _objToUser(context, idx) {
    var obj = users[idx];
    String title = obj['fullName'];
    String subtitle = obj['jobTitle'];
    bool favorited = obj['favorited'] ?? false;

    return ListTile(
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
                    title: Text(favorited ? 'Remove from favorite' : 'Add to favorite'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        obj['favorited'] = !favorited;
                      });
                    },
              )),
              PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.block),
                    title: const Text('Block this user'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )),
              PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Delete this user'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ))
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
