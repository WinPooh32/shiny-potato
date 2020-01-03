
String validateChatSendMessage(String value){
  if (value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}