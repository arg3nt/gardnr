import 'package:flutter/material.dart';
import 'package:gardnr/db.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Text> chats = [];
    for (var chat in getChats(getSelfUid())) {
      String users = "";
      for (var uid in chat.users) {
        var gardener = getGardener(uid);
        if (gardener != null) {
          users += " ${gardener.name}";
        }
      }
      chats.add(Text("Chat with $users"));
    }
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: Column(children: chats));
  }
}
