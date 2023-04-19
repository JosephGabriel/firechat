import 'dart:async';
import 'dart:math';

import 'package:firechat/models/chat.dart';
import 'package:firechat/models/chat_user.dart';

import 'package:firechat/services/chat.dart';

class ChatServiceMock implements ChatService {
  static final List<ChatMessage> _msgs = [];

  static MultiStreamController<List<ChatMessage>>? _controller;

  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_msgs.reversed.toList());
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String message, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: message,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageUrl,
    );

    _msgs.add(newMessage);

    _controller?.add(_msgs.reversed.toList());

    return newMessage;
  }
}
