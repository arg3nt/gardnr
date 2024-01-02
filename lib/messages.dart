import 'package:flutter/material.dart';
import 'package:gardnr/db.dart';
import 'package:gardnr/objects.dart';

String lastModifiedString(DateTime lastModified) {
  var diff = DateTime.now().difference(lastModified);
  return switch (diff) {
    < const Duration(seconds: 30) => "Just now",
    < const Duration(hours: 1) => "${diff.inMinutes} min ago",
    < const Duration(hours: 2) => "1 hr ago",
    < const Duration(days: 1) => "${diff.inHours} hrs ago",
    < const Duration(days: 2) => "1 day ago",
    < const Duration(days: 365) => "${diff.inDays} days ago",
    _ => "A long time ago"
  };
}

String lastMessage(Chat chat) {
  List<ChatMessage> lastMsg = chat.getLastNMessages(1, null);
  if (lastMsg.isEmpty) {
    return "No messages (yet)";
  }
  return "\"${lastMsg[0].contents}\"";
}

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    String chatTitle = chat.users.fold("", (agg, uid) {
      if (uid == getSelfUid()) return agg;

      var user = getGardener(uid);
      if (user == null) return agg;
      if (agg.isEmpty) return user.name;

      return "$agg, ${user.name}";
    });

    return Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            splashColor: Colors.lightGreen,
            onTap: () {},
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          style: Theme.of(context).textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                          chatTitle),
                      Text(
                        style: Theme.of(context).textTheme.bodyMedium,
                        lastModifiedString(chat.lastModified),
                      ),
                      Text(
                          style: Theme.of(context).textTheme.bodyLarge,
                          lastMessage(chat))
                    ]))));
  }
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> chats = [];
    for (var chat in getChats(getSelfUid())) {
      chats.add(MessageCard(chat: chat));
    }

    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          padding: const EdgeInsets.all(10),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: chats,
        ));
  }
}
