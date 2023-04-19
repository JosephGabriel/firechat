import 'package:firechat/models/chat.dart';
import 'package:firechat/models/chat_user.dart';
import 'package:firechat/services/chat_firebase.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();

  Future<ChatMessage> save(String message, ChatUser user);

  factory ChatService() {
    return ChatServiceFirebase();
  }
}
