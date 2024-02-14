class ChatModel {
  final String name;
  final String message;
  final String time;
  final bool isMe;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    this.isMe = false,
  });
}
