import 'package:flutter/material.dart';
import 'package:geminista/model/chat_model.dart';
import 'package:geminista/provider/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatTextField extends StatelessWidget {
  ChatTextField({
    super.key,
    required this.onSend,
  });
  final TextEditingController message = TextEditingController();
  final Function onSend;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: message,
              decoration: const InputDecoration(
                hintText: 'Type a message',
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            ChatProvider chatProvider = Provider.of<ChatProvider>(context, listen: false);
            chatProvider.addChat(
              ChatModel(
                name: "User",
                message: message.text,
                time: DateTime.now().toString(),
                isMe: true,
              ),
            );
            await chatProvider.generateChat(message.text);
            message.clear();
            onSend();
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
