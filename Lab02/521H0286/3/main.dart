import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.teal,
        child: SafeArea(
          child: Column(
            children: [
              Row(),
              const SizedBox(height: 50),

              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 5, color: Colors.white),
                ),
                child: const CircleAvatar(
                  radius: 56,
                  backgroundImage: NetworkImage(
                      'https://dogtime.com/wp-content/uploads/sites/12/2019/11/basset-retriever-mixed-dog-breed-pictures-cover.jpg'),
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                'Ly Manh Phi',
                style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              const Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),

              const Divider(
                indent: 50,
                endIndent: 50,
                height: 1,
                color: Colors.white,
              ),

              const SizedBox(height: 30),
              Card(
                elevation: 20,
                child: ListTile(
                  onTap: () {
                    print('Tapped');
                  },
                  leading: Icon(Icons.phone),
                  title: const Text('+84 167 405 657',
                    style: TextStyle(color: Colors.teal, fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Card(
                elevation: 20,
                child: ListTile(
                  onTap: () {
                    print('Tapped');
                  },
                  leading: Icon(Icons.mail),
                  title: const Text('521h0286@gmail.com',
                    style: TextStyle(color: Colors.teal, fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Card(
                elevation: 20,
                child: ListTile(
                  onTap: () {
                    print('Tapped');
                  },
                  leading: Icon(Icons.meeting_room),
                  title: const Text('meets.google.com/manh-phi',
                    style: TextStyle(color: Colors.teal, fontSize: 18),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
