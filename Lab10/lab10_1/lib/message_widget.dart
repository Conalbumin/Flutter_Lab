import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'chat_message.dart';

Color bgBlue = Color(0xFFE3ECFD);
Color bgGrey = Colors.grey[300]!;

class Message extends StatelessWidget {
  Message(this.message, {super.key});
  ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return message.isStatus
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              message.message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 0),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            alignment:
                message.isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: message.isMe ? bgBlue : bgGrey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: message.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!message.isMe)
                    Text(
                      message.from,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.pink),
                    ),
                  if (!message.isMe)
                    SizedBox(
                      height: 4,
                    ),
                  Text(message.message),
                ],
              ),
            ),
          );
  }
}
