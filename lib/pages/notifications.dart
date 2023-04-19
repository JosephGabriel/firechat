import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firechat/services/notification.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Notificações'),
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(service.items[i].title),
          subtitle: Text(service.items[i].body),
          onTap: () => service.remove(i),
        ),
      ),
    );
  }
}
