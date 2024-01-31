import 'dart:async';
import 'package:flutter/material.dart';
import 'message_widget.dart';
import 'chat_message.dart';

const WEB_URL = 'ws://localhost:3000'; // kết nối từ web
const ANDROID_URL = 'ws://10.0.2.2:3000'; // kết nối từ máy ảo android

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChatScreen(),
  ));
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> _chatMessages = [];
  ChatMessage? lastMessage;

  void initSampleData() {
    _chatMessages.add(ChatMessage(
        from: 'Minh Tuấn',
        message: 'Đây là giao diện minh họa cho ứng dụng chat',
        isMe: false));
    _chatMessages.add(ChatMessage(
        from: 'Châu Loan',
        message:
            'Bạn cần: kết nối đến websocket server theo hướng dẫn của giảng viên',
        isMe: false));
    _chatMessages.add(ChatMessage(
        from: 'me',
        message:
            'Sau khi kết nối thành công, cần gửi tín hiệu đăng ký display name trong tin nhắn đầu tiên',
        isMe: true));
    _chatMessages.add(ChatMessage(
        from: 'system',
        message: 'Minh Tuấn đã rời phòng chat',
        isMe: false,
        isStatus: true));
    _chatMessages.add(ChatMessage(
        from: 'Quang Hà',
        message:
            'Bạn hãy soạn và gửi một tin nhắn, sau 1 giây tin nhắn sẽ được phản hồi ngược lại',
        isMe: false));
  }

  @override
  void initState() {
    initSampleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiển thị tên user ở đây'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ChatConversation(_chatMessages),
            Divider(),
            ChatBox(_sendMessage),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage(String message) async {
    // hiển thị tin nhắn của tôi
    setState(() {
      _chatMessages.add(ChatMessage(from: 'me', message: message, isMe: true));
    });

    await Future.delayed(Duration(seconds: 1)); // chờ 1 giây

    // mô phỏng hiện thị câu trả lời
    setState(() {
      _chatMessages.add(ChatMessage(
          from: 'Tuấn', message: message.toUpperCase(), isMe: false));
    });
  }
}

// widget hiển thị cuộc trò chuyện
class ChatConversation extends StatelessWidget {
  final List<ChatMessage> messages;
  ChatConversation(this.messages, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return Message(messages[index]);
        },
      ),
    );
  }
}

// widget hiển thị textfield và button gửi đi
class ChatBox extends StatelessWidget {
  ChatBox(this.sendMessage, {super.key});

  final void Function(String) sendMessage;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (e) {
                sendMessage(_textEditingController.text);
                _textEditingController.clear();
              },
              textInputAction: TextInputAction.send,
              maxLines: 3,
              controller: _textEditingController,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration.collapsed(hintText: "Nhập tin nhắn"),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              sendMessage(_textEditingController.text);
            },
          ),
        ],
      ),
    );
  }
}
