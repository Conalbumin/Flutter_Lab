import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepPurple),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _fileNameController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  List<String> fileNames = [];

  @override
  void initState() {
    super.initState();
    _loadFileNames();
  }

  void _loadFileNames() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = directory.listSync();
    setState(() {
      fileNames.clear();
      for (var file in files) {
        if (file is File) {
          fileNames.add(file.path.split('/').last);
        }
      }
    });
  }

  void _saveFile() async {
    final String fileName = _fileNameController.text.trim();
    final String content = _contentController.text.trim();
    if (fileName.isNotEmpty && content.isNotEmpty) {
      try {
        final Directory directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/$fileName');
        await file.writeAsString(content);
        _fileNameController.clear();
        _contentController.clear();
        _loadFileNames();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File saved successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving file')),
        );
      }
    }
  }

  void _readFile(String fileName) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$fileName');
      String content = await file.readAsString();
      _fileNameController.text = fileName;
      _contentController.text = content;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error reading file')),
      );
    }
  }

  void _deleteFile(String fileName) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$fileName');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete: $fileName'),
            content: Text('Are you sure want to delete this file?'),
            actions: [
              TextButton(
                onPressed: () async {
                  await file.delete();
                  Navigator.of(context).pop();
                  _loadFileNames();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('File deleted successfully')),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting file')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Manager'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 24),
            TextFormField(
              controller: _fileNameController,
              decoration: InputDecoration(
                labelText: 'File Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveFile,
                    child: Text('Save or Update'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      String fileName = _fileNameController.text.trim();
                      if (fileName.isNotEmpty) {
                        _readFile(fileName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter a file name')),
                        );
                      }
                    },
                    child: Text('Read file'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemBuilder: (ctx, idx) => ListTile(
                  onTap: () {
                    _readFile(fileNames[idx]);
                  },
                  title: Text(fileNames[idx]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteFile(fileNames[idx]);
                    },
                  ),
                ),
                separatorBuilder: (ctx, idx) => Divider(
                  height: 1,
                ),
                itemCount: fileNames.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
