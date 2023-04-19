import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firechat/models/auth_form.dart';
import 'package:firechat/components/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formData = AuthFormData();

  final _formKey = GlobalKey<FormState>();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Image não selecionada');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                UserImagePicker(onImagePick: _handleImagePick),
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    final name = value ?? '';

                    if (name.trim().length < 3) {
                      return 'Nome deve ter pelo menos 3 caracteres';
                    }

                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  final email = value ?? '';

                  if (email.contains('@')) {
                    return 'O email informado é inválido';
                  }

                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                obscureText: true,
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                decoration: const InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  final password = value ?? '';

                  if (password.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _formData.isLogin ? 'Entrar' : 'Cadastrar',
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleMode();
                  });
                },
                child: Text(
                  _formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
