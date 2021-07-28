import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  NewMessage({Key? key}) : super(key: key);

  @override
  NewMessageState createState() => NewMessageState();
}

class NewMessageState extends State<NewMessage> {
  var message = "";
  final messageController = TextEditingController();

  _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection("chat").add({
      "text": message,
      "createAt":Timestamp.now(),
    });
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: TextField(
          controller: messageController,
          onChanged: (value) {
            setState(() {
              message = value;
            });
          },
        ),
      ),
      IconButton(
        color: Theme.of(context).primaryColor,
        onPressed: message.trim().isEmpty ? null : _sendMessage,
        icon: Icon(
          Icons.send_outlined,
          color: Colors.green,
        ),
      ),
    ]);
  }
}
