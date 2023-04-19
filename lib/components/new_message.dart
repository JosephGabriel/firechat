import 'package:firechat/services/auth.dart';
import 'package:firechat/services/chat.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';

  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      await ChatService().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (value) => setState(() {
              _message = value;
            }),
            onSubmitted: (_) {
              if (_message.trim().isNotEmpty) {
                _sendMessage();
              }
            },
            decoration: const InputDecoration(
              labelText: 'Enviar mensagem',
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: _message.trim().isEmpty ? null : _sendMessage,
        )
      ],
    );
  }
}
