import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isTextBold = false;
  bool isTextColor = false;
  bool isTextLarge = false;
  TextEditingController textEditingController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  String currentMessage = '';

  void toggleBold() {
    setState(() {
      isTextBold = !isTextBold;
    });
  }

  void toggleColor() {
    setState(() {
      isTextColor = !isTextColor;
    });
  }

  void toggleLarge() {
    setState(() {
      isTextLarge = !isTextLarge;
    });
  }

  Widget getThumbUpIcon(Map<String, dynamic> message) {
    double iconSize = 30.0;
    if (message['isLarge']) {
      iconSize = 60.0;
    }

    return Icon(
      Icons.thumb_up,
      size: iconSize,
      color: Colors.green.shade800,
    );
  }

  TextStyle getMessageStyle(Map<String, dynamic> message) {
    return TextStyle(
      fontWeight: message['isBold'] ? FontWeight.bold : FontWeight.normal,
      color: message['isColor'] ? Colors.blue : null,
      fontSize: message['isLarge'] ? 60 : null,
    );
  }

  void onSaveButtonPressed() {
    String messageText = textEditingController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        // Add the current message with current formatting options
        messages.add({
          'text': messageText,
          'isBold': isTextBold,
          'isColor': isTextColor,
          'isLarge': isTextLarge,
        });
      });

      // Reset formatting options
      setState(() {
        isTextBold = false;
        isTextColor = false;
        isTextLarge = false;
      });

      // Clear the current message
      setState(() {
        currentMessage = '';
      });

      // Reset TextField
      textEditingController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a message.'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('User Interaction')),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: textEditingController,
            decoration: const InputDecoration(label: Text('Type a message')),
            style: TextStyle(
              fontWeight:
                  currentMessage == textEditingController.text && isTextBold
                      ? FontWeight.bold
                      : FontWeight.normal,
              color: currentMessage == textEditingController.text && isTextColor
                  ? Colors.blue
                  : null,
              fontSize:
                  currentMessage == textEditingController.text && isTextLarge
                      ? 35
                      : 25,
            ),
            onChanged: (value) {
              // Update the current message with current formatting options
              setState(() {
                currentMessage = value;
              });
            },
            onSubmitted: (value) {
              onSaveButtonPressed();
            },
          ),
          Row(
            children: [
              const SizedBox(width: 15),
              Expanded(
                child: Row(children: [
                  Switch(
                    value: isTextBold,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      toggleBold();
                    },
                  ),
                  const Text('Bold'),
                ]),
              ),
              Expanded(
                child: Row(children: [
                  Switch(
                    value: isTextColor,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      toggleColor();
                    },
                  ),
                  const Text('Color'),
                ]),
              ),
              Expanded(
                child: Row(children: [
                  Switch(
                    value: isTextLarge,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      toggleLarge();
                    },
                  ),
                  const Text('Large'),
                ]),
              ),
              const SizedBox(width: 15),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              fixedSize: const Size(350, 35),
            ),
            onPressed: onSaveButtonPressed,
            child: const Text('Save', style: TextStyle(fontSize: 25)),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: getThumbUpIcon(messages[index]),
                    title: Text(
                      messages[index]['text'],
                      style: getMessageStyle(messages[index]),
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
