import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widget/messages/messages.dart';
import 'package:flutter_chat/widget/messages/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                        SizedBox(width: 15),
                        Text("SignOut"),
                      ],
                    ),
                  ),
                  value: "logout",
                ),
              ],
              onChanged: (data) {
                if (data == "logout") {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
             SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
