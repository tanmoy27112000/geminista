import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiHelper {
  GeminiHelper._privateConstructor();
  static final GeminiHelper _instance = GeminiHelper._privateConstructor();
  static GeminiHelper get instance => _instance;

  String gemini_key = "AIzaSyCJVwbG6xrYVNyuocnYDemrmeNtwMircEs";

  init() {
    Gemini.init(apiKey: gemini_key);
  }

  // generate response function
  Future<String> getResponse(String query) async {
    try {
      final gemini = Gemini.instance;
      final result = await gemini.text(query);
      return result?.content?.parts?.last.text ?? "Sorry, there was a error";
    } catch (e) {
      return "Sorry, I can't do that.";
    }
  }
}
