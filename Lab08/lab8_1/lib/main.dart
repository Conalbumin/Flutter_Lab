// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepPurple),
    home: UserPreferencesScreen(),
  ));
}

class UserPreferencesScreen extends StatefulWidget {
  const UserPreferencesScreen({Key? key}) : super(key: key);

  @override
  _UserPreferencesScreenState createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  String _language = 'English';
  String _colorTheme = 'Light';
  bool notification = false;
  var videoQualities = [
    '720p HD at 30 fps',
    '1080p HD at 30 fps',
    '1080p HD at 60 fps',
    '4K at 30 fps',
    '4K at 60 fps'
  ];
  String _selectedVideoQuality = '';
  String _displayName = 'N/A';

  void _onLanguageChanged(String? value) {
    setState(() {
      _language = value ?? '';
    });
  }

  void _onColorThemeChanged(String? value) {
    setState(() {
      _colorTheme = value ?? '';
    });
  }

  void _videoRecodingbottomSheet() async {
    final selectedValue = await showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        alignment: Alignment.center,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: videoQualities.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(videoQualities[index]),
              onTap: () {
                Navigator.pop(context, videoQualities[index]);
              },
            );
          },
        ),
      ),
    );

    if (selectedValue != null) {
      setState(() {
        _selectedVideoQuality = selectedValue;
      });
    }
  }

  void _changeDisplayName() {
    TextEditingController _displayNameController =
        TextEditingController(); // Step 1

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Change Display Name'),
        content: TextField(
          // Step 2
          controller: _displayNameController,
          decoration: InputDecoration(hintText: 'Enter your display name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _displayName = _displayNameController.text;
              });
              print(_displayName);
              Navigator.pop(context);
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('User Preferences'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Display Name',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextFormField(
                onTap: _changeDisplayName,
                controller: TextEditingController(text: _displayName),
                readOnly: true,
                decoration: InputDecoration(),
              ),
              SizedBox(height: 20),
              Text(
                'Language',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              DropdownButtonFormField<String>(
                value: _language,
                onChanged: _onLanguageChanged,
                items: <String>['English', 'Spanish', 'French', 'German']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Color Theme',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              DropdownButtonFormField<String>(
                value: _colorTheme,
                onChanged: _onColorThemeChanged,
                items: <String>['Light', 'Dark']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Notification',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                value: notification,
                onChanged: (v) {
                  setState(() {
                    notification = v;
                  });
                },
                title: Text('Banners, Sounds, Badges'),
              ),
              SizedBox(height: 20),
              Text(
                'Record Video',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextFormField(
                onTap: _videoRecodingbottomSheet,
                controller: TextEditingController(text: _selectedVideoQuality),
                readOnly: true,
                decoration:
                    InputDecoration(suffixIcon: Icon(Icons.arrow_drop_down)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
