import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        vertical: 4,
      ),
      elevation: 0.5,
      child: InkWell(
        onTap: () {},
        child: const ListTile(
          //User profile picture
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.person_alt),
          ),

          //User name
          title: Text('Demo User'),

          //Last message
          subtitle: Text(
            'Last User Message',
            maxLines: 1,
          ),

          //Last message time
          trailing: Text(
            '12.00',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
