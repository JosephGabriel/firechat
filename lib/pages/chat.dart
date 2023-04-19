import 'package:firechat/pages/notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firechat/components/messages.dart';
import 'package:firechat/components/new_message.dart';

import 'package:firechat/services/auth.dart';
import 'package:firechat/services/notification.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Sair'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const NotificationsPage()),
                  );
                },
                icon: const Icon(Icons.notifications),
              ),
              Positioned(
                  child: CircleAvatar(
                maxRadius: 10,
                backgroundColor: Colors.red.shade800,
                child: Text(
                  '${Provider.of<ChatNotificationService>(context).itemsCount}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ))
            ],
          ),
        ],
      ),
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
