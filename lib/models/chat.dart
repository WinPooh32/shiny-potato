import 'package:openapi/api.dart' as api;
import 'package:flutter/material.dart';

class Message{
  final String sender;
  final String message;

  const Message(this.sender, this.message);
}

class ChatModel with ChangeNotifier {
  final api.DefaultApi chatAPI;

  List<Message> _items = [];
  String _sendField = "";

  ChatModel(this.chatAPI);

  List<Message> get items => _items;

  String get sendField => _sendField;
  set sendField(String value) => _sendField = value;

  void add(String sender, String message) {
    _items.add(Message(sender, message));
    notifyListeners();
  }

  void clear(){
    _sendField = "";
    notifyListeners();
  }

  void submit() async {
    // do some net code
    add("Me> ", sendField);

    var msg = api.Message();
    msg.payload = sendField;
    msg.room = "1234567891234567";

    chatAPI.sendMessage(msg);

    // clear() notify listeners
    clear();
  }
}

