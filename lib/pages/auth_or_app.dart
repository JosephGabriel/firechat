import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firechat/pages/auth.dart';
import 'package:firechat/pages/chat.dart';
import 'package:firechat/pages/loading.dart';

import 'package:firechat/models/chat_user.dart';

import 'package:firechat/services/auth.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: init(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }

          return StreamBuilder<ChatUser?>(
            stream: AuthService().userChanges,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              } else {
                return snapshot.hasData ? const ChatPage() : const AuthPage();
              }
            }),
          );
        });
  }
}
