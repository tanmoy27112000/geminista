import 'package:flutter/material.dart';
import 'package:geminista/model/chat_model.dart';
import 'package:geminista/provider/chat_provider.dart';
import 'package:geminista/widget/chat_text_field.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geminista'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ChatProvider>(context, listen: false).clearChat();
            },
            icon: const Icon(Icons.clear_all),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                return Stack(
                  children: [
                    chatProvider.chatList.isEmpty
                        ? const Center(
                            child: Text(
                              "Start chatting with geminista",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: chatProvider.chatList.length,
                            itemBuilder: (context, index) {
                              final chat = chatProvider.chatList[index];
                              return Column(
                                children: [
                                  ChatBubble(
                                    chatModel: chat,
                                  ),
                                  if (chatProvider.isLoading && index == chatProvider.chatList.length - 1)
                                    const Center(
                                      child: CircularProgressIndicator.adaptive(),
                                    ),
                                ],
                              );
                            },
                          ),
                  ],
                );
              },
            ),
          ),
          ChatTextField(onSend: () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }),
        ],
      )),
    );
  }
}

class ChatBubble extends StatefulWidget {
  final ChatModel chatModel;
  const ChatBubble({super.key, required this.chatModel});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.chatModel.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.chatModel.isMe ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(widget.chatModel.message,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              )),
        ),
      ),
    );
  }
}
