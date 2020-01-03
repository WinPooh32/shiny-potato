import 'package:flutter/material.dart';
import 'package:idea_chat/models/chat.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class MessagesViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ChatModel>(context).items;

    return ListView.builder(
        reverse: true,
//        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        itemCount: items.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (items.length <= 0) {
            return null;
          }

          if (index == items.length) {
            return Center(child: CircularProgressIndicator());
          }

          final int reversedIndex = items.length - index - 1;
          final msg = items[reversedIndex];

          return Row(
            children: <Widget>[Text(msg.sender), Text(msg.message)],
          );
        });
  }
}

class TextEditWidget extends StatefulWidget {
  @override
  _TextEditWidgetState createState() => _TextEditWidgetState();
}

class _TextEditWidgetState extends State<TextEditWidget> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ChatModel model = Provider.of<ChatModel>(context);

    final txtField = TextField(
      onChanged: (changed) => model.sendField = changed,
      onSubmitted: (submitted) {
        model.sendField = submitted;
        model.submit();
      },
      controller: _textEditingController,
    );

    final btnSend = FlatButton(
      onPressed: () {
        model.submit();
      },
      child: Icon(Icons.send),
    );

    txtField.controller.text = model.sendField;

    return Row(
      children: <Widget>[
        Flexible(child: txtField),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: btnSend,
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textEditingController.dispose();
    super.dispose();
  }
}

class Chat extends StatelessWidget {
  final DefaultApi chatAPI;

  Chat(this.chatAPI);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: ChangeNotifierProvider<ChatModel>(
          builder: (context) => ChatModel(this.chatAPI),
          child: Column(
            children: <Widget>[
              Expanded(child: MessagesViewer()),
              TextEditWidget(),
            ],
          ),
        ));
  }
}
