import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _key = GlobalKey<FormState>();
  String username = '';
  String email = '';
  int age = 18;

  void _handleSubmit() {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState?.save();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:
            const Text("Form Handling", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (v) {
                    username = v ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your username';
                    return null;
                  },
                  maxLines: 1,
                  maxLength: 30,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                    suffixIcon: Icon(Icons.check),
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  onSaved: (v) {
                    email = v ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your email';
                    if (!value.contains('@')) return 'This is not a valid email address';
                    return null;
                  },
                  maxLines: 1,
                  maxLength: 30,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                    suffixIcon: Icon(Icons.check),
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  onSaved: (v) {
                    age = v != null ? int.parse(v) : 18;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your age';
                    if (int.parse(value) < 18) return 'You must be older than 17';
                    if (int.parse(value) > 100) return 'You must be younger than 100';
                    return null;
                  },
                  maxLines: 1,
                  maxLength: 30,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    hintText: 'Enter your age',
                    prefixIcon: Icon(Icons.timer),
                    suffixIcon: Icon(Icons.check),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _handleSubmit();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size.fromHeight(50)),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
