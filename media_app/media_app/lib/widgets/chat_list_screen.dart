import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  final List<Map<String, String>> chats = [
    {'name': 'Alice', 'image': 'https://i.pravatar.cc/150?img=1'},
    {'name': 'Bob', 'image': 'https://i.pravatar.cc/150?img=2'},
    {'name': 'Charlie', 'image': 'https://i.pravatar.cc/150?img=3'},
    {'name': 'Diana', 'image': 'https://i.pravatar.cc/150?img=4'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chat['image']!),
          ),
          title: Text(chat['name']!),
          subtitle: Text('Hey, how are you?'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  userName: chat['name']!,
                  userImage: chat['image']!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}