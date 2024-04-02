class ChatMessage {
  String from;
  String message;
  bool isMe;
  bool isStatus;

  ChatMessage(
      {required this.from,
      required this.message,
      required this.isMe,
      this.isStatus = false});
}
