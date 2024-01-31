// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Note'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(),
            SizedBox(
              height: 12,
            ),
            TextFormField(),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Save Note'),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
            )
          ],
        ),
      ),
    );
  }
}
