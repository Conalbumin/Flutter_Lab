import 'package:flutter/material.dart';

var notes = [
  {
    'id': 1,
    'title': 'Việt Nam khởi đầu tốt nhất lịch sử dự U20 châu Á',
    'content':
        'Lần đầu trong lịch sử 64 năm của giải U20 châu Á, Việt Nam thắng cả hai trận đầu tiên, trước Australia và Qatar.',
    'isProtected': false,
  },
  {
    'id': 2,
    'title': 'Thành tích ấn tượng của U20 Việt Nam tại giải châu Á',
    'content':
        'Đội U20 Việt Nam đã ghi dấu ấn mạnh mẽ khi thắng cả hai trận đầu tiên trong lịch sử tham dự giải U20 châu Á.',
    'isProtected': false,
  },
  {
    'id': 3,
    'title': 'Việt Nam chinh phục giải U20 châu Á với bước đầu ngoạn mục',
    'content':
        'Sự thành công của đội U20 Việt Nam tại giải châu Á đã làm nổi bật tên tuổi của đội bóng và của quốc gia trên bản đồ bóng đá thế giới.',
    'isProtected': false,
  },
  {
    'id': 4,
    'title': 'U20 Việt Nam: Niềm tự hào mới của bóng đá nước nhà',
    'content':
        'Sau hai trận đấu ấn tượng, U20 Việt Nam đã thu hút sự chú ý và tạo ra cảm hứng lớn cho người hâm mộ bóng đá Việt Nam.',
    'isProtected': false,
  },
  {
    'id': 5,
    'title': 'Thành công đầu tiên của U20 Việt Nam tại giải châu Á',
    'content':
        'Với việc thắng cả hai trận đầu tiên, U20 Việt Nam đã viết nên một trang lịch sử mới cho bóng đá đất nước.',
    'isProtected': false,
  },
  {
    'id': 6,
    'title': 'U20 Việt Nam tạo ra cơn sốt tại giải châu Á',
    'content':
        'Sự tỏa sáng của đội U20 Việt Nam đã khiến cả khu vực và cả thế giới bóng đá phải nể phục.',
    'isProtected': false,
  }
];

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  Widget _createNoteWidget(Map<String, Object> note) {
    return ListTile(
      title: Text(note['title'] as String),
      subtitle: Text(
        note['content'] as String,
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
        children: notes.map((note) => _createNoteWidget(note)).toList(),
      ),
    );
  }
}
