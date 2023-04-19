import 'package:firechat/components/message_bubble.dart';
import 'package:firechat/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:firechat/models/chat.dart';
import 'package:firechat/services/chat.dart';

import 'package:firechat/pages/loading.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: LoadingPage(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Sem dados, vamos conversar?'),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, i) => MessageBubble(
                key: ValueKey(msgs[i].id),
                message: msgs[i],
                belongsToCurrentUser: msgs[i].userId == currentUser?.id),
          );
        }
      },
    );
  }
}
