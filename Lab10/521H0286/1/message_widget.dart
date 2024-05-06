import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'chat_message.dart';

Color bgBlue = const Color(0xFFC6CACE);
Color bgGrey = Colors.grey[300]!;

class Message extends StatelessWidget {
  Message(this.message, {Key? key});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return message.isStatus
        ? Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        message.message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.grey),
      ),
    )
        : Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isMe)
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                message.from.substring(0, 1).toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!message.isMe)
                Text(
                  message.from,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.pink),
                ),
              Container(
                constraints: const BoxConstraints(maxWidth: 200),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: message.isMe ? bgBlue : bgGrey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message.message),
                    Text(
                      '${message.time.hour}:${message.time.minute}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
