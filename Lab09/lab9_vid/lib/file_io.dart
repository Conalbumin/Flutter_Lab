import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class FileIOApp extends StatefulWidget {
  const FileIOApp({Key? key}) : super(key: key);

  @override
  State<FileIOApp> createState() => _FileIOAppState();
}

class _FileIOAppState extends State<FileIOApp> {
  String message = 'Enter file name and text content to continue';
  var _fileNameController = TextEditingController();
  var _fileContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'File IO App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: _fileNameController,
              decoration: const InputDecoration(labelText: 'File Name'),
            ),
            TextFormField(
              controller: _fileContentController,
              decoration: const InputDecoration(labelText: 'Message'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Save'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _readData,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Read'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(message)
          ],
        ),
      ),
    );
  }

  void _saveData() async {
    var root = await getApplicationDocumentsDirectory();
    String filePath = join(root.path, _fileNameController.text);
    var file = File(filePath);
    await file.writeAsString(_fileContentController.text);
    setState(() {
      message = 'File saved';
    });
    print('saved');
  }

  void _readData() async {
    var root = await getApplicationDocumentsDirectory();
    String filePath = join(root.path, _fileNameController.text);
    var file = File(filePath);
    String value = await file.readAsString();
    setState(() {
      message = value;
    });
  }
}
