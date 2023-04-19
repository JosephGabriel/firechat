import 'package:flutter/material.dart';

import 'package:firechat/components/auth_form.dart';

import 'package:firechat/models/auth_form.dart';

import 'package:firechat/services/auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        await AuthService().login(formData.email, formData.password);
      } else {
        await AuthService().signup(
            formData.name, formData.email, formData.password, formData.image);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (_isLoading)
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
