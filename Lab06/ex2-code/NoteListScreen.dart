// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  var notes = [
    {
      'title': 'Việt Nam khởi đầu tốt nhất lịch sử dự U20 châu Á',
      'content':
          'Lần đầu trong lịch sử 64 năm của giải U20 châu Á, Việt Nam thắng cả hai trận đầu tiên, trước Australia và Qatar.'
    },
    {
      'title': 'Truyền thông Indonesia khen U20 Việt Nam phi thường',
      'content':
          'Nhiều báo, đài Indonesia ngạc nhiên khi Việt Nam toàn thắng hai trận đầu ở bảng đấu khó tại vòng chung kết U20 châu Á 2023'
    },
    {
      'title': 'Việt Nam khởi đầu tốt nhất lịch sử dự U20 châu Á',
      'content':
          'Lần đầu trong lịch sử 64 năm của giải U20 châu Á, Việt Nam thắng cả hai trận đầu tiên, trước Australia và Qatar.'
    },
    {
      'title': 'Truyền thông Indonesia khen U20 Việt Nam phi thường',
      'content':
          'Nhiều báo, đài Indonesia ngạc nhiên khi Việt Nam toàn thắng hai trận đầu ở bảng đấu khó tại vòng chung kết U20 châu Á 2023'
    },
    {
      'title': 'Việt Nam khởi đầu tốt nhất lịch sử dự U20 châu Á',
      'content':
          'Lần đầu trong lịch sử 64 năm của giải U20 châu Á, Việt Nam thắng cả hai trận đầu tiên, trước Australia và Qatar.'
    },
    {
      'title': 'Truyền thông Indonesia khen U20 Việt Nam phi thường',
      'content':
          'Nhiều báo, đài Indonesia ngạc nhiên khi Việt Nam toàn thắng hai trận đầu ở bảng đấu khó tại vòng chung kết U20 châu Á 2023'
    },
  ];

  Widget _createNoteWidget(note) {
    return ListTile(
      title: Text(note['title']),
      subtitle: Text(
        note['content'],
        maxLines: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Management'),
      ),
      body: ListView(
        children: notes.map(_createNoteWidget).toList(),
      ),
    );
  }
}
