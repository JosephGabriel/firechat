import 'package:firechat/models/notification.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _items = [];

  List<ChatNotification> get items => [..._items];

  int get itemsCount => _items.length;

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
  }
}
