class ChatMessage {
  String from;
  String message;
  bool isMe;
  bool isStatus;
  late DateTime time;

  ChatMessage(
      {required this.from,
      required this.message,
      required this.isMe,
      this.isStatus = false,
      required this.time});

  ChatMessage.fromJson(Map<String, dynamic> json)
      : from = json['from'],
        message = json['message'],
        isMe = json['isMe'],
        isStatus = json['isStatus'],
        time = DateTime.parse(json['time']);

  Map<String, dynamic> toJson() => {
        'from': from,
        'message': message,
        'isMe': isMe,
        'isStatus': isStatus,
        'time': time.toString(),
      };
}
