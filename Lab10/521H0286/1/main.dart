import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab10_1/register_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'message_widget.dart';
import 'chat_message.dart';

const WEB_URL = 'ws://localhost:3000'; // kết nối từ web
const ANDROID_URL = 'ws://10.0.2.2:3000'; // kết nối từ máy ảo android

void main(List<String> args) {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegisterScreen(),
  ));
}

class ChatScreen extends StatefulWidget {
  String fullName;

  ChatScreen(this.fullName);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> _chatMessages = [];
  ChatMessage? lastMessage;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initWebsocket();
    loadMessages();
    super.initState();
  }

  final channel =
      WebSocketChannel.connect(Uri.parse(kIsWeb ? WEB_URL : ANDROID_URL));

  void initWebsocket() {
    channel.sink
        .add(jsonEncode({'type': 'register', 'message': widget.fullName}));
    channel.stream.listen((event) {
      String input = event.toString();
      var msg = jsonDecode(input);
      var type = msg['type'];
      var text = msg['message'];
      var from = msg['from'] ?? 'system';

      var chat = ChatMessage(
          from: from,
          message: text,
          isMe: from == widget.fullName,
          isStatus: type == 'info',
          time: DateTime.now());

      setState(() {
        _chatMessages.add(chat);
      });

      scrollToBottom();
      saveMessages();
    });
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? messagesJson = prefs.getStringList('chatMessages');
    if (messagesJson != null) {
      List<ChatMessage> messages = messagesJson
          .map((json) => ChatMessage.fromJson(jsonDecode(json)))
          .toList();
      setState(() {
        _chatMessages = messages;
      });
      await Future.delayed(const Duration(milliseconds: 100));
      scrollToBottom();
    }
  }

  Future<void> saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> messagesJson =
        _chatMessages.map((message) => jsonEncode(message.toJson())).toList();
    prefs.setStringList('chatMessages', messagesJson);
  }

  Future<void> _sendMessage(String message) async {
    var msg = jsonEncode(
        {'type': 'chat', 'message': message, 'from': widget.fullName});
    channel.sink.add(msg);
    await Future.delayed(const Duration(milliseconds: 100));
    scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.fullName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _chatMessages.length,
                itemBuilder: (context, index) {
                  return Message(_chatMessages[index]);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: ChatBox(_sendMessage),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatConversation extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatConversation(this.messages, {super.key});

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

class ChatBox extends StatelessWidget {
  ChatBox(this.sendMessage, {super.key});

  final void Function(String) sendMessage;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              style: const TextStyle(fontSize: 20),
              decoration:
                  const InputDecoration.collapsed(hintText: "Nhập tin nhắn"),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              sendMessage(_textEditingController.text);
            },
          ),
        ],
      ),
    );
  }
}
