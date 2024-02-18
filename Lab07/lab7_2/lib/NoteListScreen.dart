import 'package:flutter/material.dart';

var notes = [
    {
      'id': 1,
      'title': 'Việt Nam khởi đầu tốt nhất lịch sử dự U20 châu Á',
      'content': 'Lần đầu trong lịch sử 64 năm của giải U20 châu Á, Việt Nam thắng cả hai trận đầu tiên, trước Australia và Qatar.'
    },
    {
      'id': 2,
      'title': 'Thành tích ấn tượng của U20 Việt Nam tại giải châu Á',
      'content': 'Đội U20 Việt Nam đã ghi dấu ấn mạnh mẽ khi thắng cả hai trận đầu tiên trong lịch sử tham dự giải U20 châu Á.'
    },
    {
      'id': 3,
      'title': 'Việt Nam chinh phục giải U20 châu Á với bước đầu ngoạn mục',
      'content': 'Sự thành công của đội U20 Việt Nam tại giải châu Á đã làm nổi bật tên tuổi của đội bóng và của quốc gia trên bản đồ bóng đá thế giới.'
    },
    {
      'id': 4,
      'title': 'U20 Việt Nam: Niềm tự hào mới của bóng đá nước nhà',
      'content': 'Sau hai trận đấu ấn tượng, U20 Việt Nam đã thu hút sự chú ý và tạo ra cảm hứng lớn cho người hâm mộ bóng đá Việt Nam.'
    },
    {
      'id': 5,
      'title': 'Thành công đầu tiên của U20 Việt Nam tại giải châu Á',
      'content': 'Với việc thắng cả hai trận đầu tiên, U20 Việt Nam đã viết nên một trang lịch sử mới cho bóng đá đất nước.'
    },
    {
      'id': 6,
      'title': 'U20 Việt Nam tạo ra cơn sốt tại giải châu Á',
      'content': 'Sự tỏa sáng của đội U20 Việt Nam đã khiến cả khu vực và cả thế giới bóng đá phải nể phục.'
    }
];

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {

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
        title: const Text('Note Management'),
      ),
      body: ListView(
        children: notes.map(_createNoteWidget).toList(),
      ),
    );
  }
}
