import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firechat/models/chat.dart';
import 'package:firechat/models/chat_user.dart';

import 'package:firechat/services/chat.dart';

class ChatServiceFirebase implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    return const Stream<List<ChatMessage>>.empty();
  }

  @override
  Future<ChatMessage> save(String message, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    final docRef = await store.collection('chat').add({
      'text': message,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageURL': user.imageUrl,
    });

    final doc = await docRef.get();

    final data = doc.data()!;

    return ChatMessage(
      id: doc.id,
      text: data['text'],
      createdAt: DateTime.parse(data['createdAt']),
      userId: data['userId'],
      userName: data['userName'],
      userImageURL: data['userImageURL'],
    );
  }

  Map<String, dynamic> _toFirestore(ChatMessage msg, SetOptions? options) {
    return {
      'text': msg.text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': msg.userId,
      'userName': msg.userName,
      'userImageURL': msg.userImageURL,
    };
  }

  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return ChatMessage(
      id: doc.id,
      text: doc['text'],
      createdAt: DateTime.parse(doc['createdAt']),
      userId: doc['userId'],
      userName: doc['userName'],
      userImageURL: doc['userImageURL'],
    );
  }
}
