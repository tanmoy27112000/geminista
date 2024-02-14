import 'package:flutter/material.dart';
import 'package:geminista/helper/gemini_helper.dart';
import 'package:geminista/model/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  bool isLoading = false;
  final List<ChatModel> _chatList = [];

  List<ChatModel> get chatList => _chatList;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  void addChat(ChatModel chatModel) {
    _chatList.add(chatModel);
    notifyListeners();
  }

  void clearChat() {
    _chatList.clear();
    notifyListeners();
  }

  generateChat(String message) async {
    startLoading();
    final result = await GeminiHelper.instance.getResponse(message);
    addChat(ChatModel(
      name: "Geminista",
      message: result,
      time: DateTime.now().toString(),
    ));
    stopLoading();
  }
}
