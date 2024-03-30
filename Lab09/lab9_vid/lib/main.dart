import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file_io.dart';
import 'package:path_provider/path_provider.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FileIOApp(),
  ));
}

class SharePreferencesApp extends StatefulWidget {
  const SharePreferencesApp({super.key});

  @override
  State<SharePreferencesApp> createState() => _SharePreferencesAppState();
}

class _SharePreferencesAppState extends State<SharePreferencesApp> {
  late SharedPreferences _pref;

  void initData() async {
    _pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Share Preferences App', style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: _saveData, 
                child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Save')
              ],
            )),
            ElevatedButton(
                onPressed: _readData, 
                child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Read')
              ],
            )),          ],
        ),
      ),
    );
  }

  void _saveData() {
    _pref.setString('name', 'Ly Manh Phi');
    _pref.setBool('notification', true);
    _pref.setInt('level', 3);
    _pref.setDouble('volume', 80.0);
    _pref.setStringList('email', ['abc@gmail.com', 'asd@gmail.com']);

    print("done");
  }

  void _readData() {
    String? name = _pref.getString('name');
    bool? notification = _pref.getBool('notification');
    int? level = _pref.getInt('level');
    double? volume = _pref.getDouble('volume');
    List<String>? emails = _pref.getStringList('email');

    print(name);
    print(notification);
    print(level);
    print(volume);
    print(emails);

  }
}
