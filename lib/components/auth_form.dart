import 'dart:io';

import 'package:flutter/material.dart';
import 'package:marvelpedia/core/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({required this.onSubmit, super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();

  // void _handleImagePick(File image) {
  //   _authFormData.image = image;
  // }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _submit() {
    bool isvalid = _formKey.currentState?.validate() ?? false;
    if (!isvalid) {
      return;
    }
    widget.onSubmit(_authFormData);
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
            children: <Widget>[
              if (_authFormData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _authFormData.name,
                  onChanged: (name) => _authFormData.name = name,
                  validator: (nameParam) {
                    final name = nameParam ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome deve ter no mínimo 5 caracteres';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _authFormData.email,
                onChanged: (email) => _authFormData.email = email,
                validator: (emailParam) {
                  final email = emailParam ?? '';
                  if (!email.contains('@')) {
                    return 'Email informado não é válido';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _authFormData.password,
                onChanged: (password) => _authFormData.password = password,
                validator: (pwdParam) {
                  final password = pwdParam ?? '';
                  if (password.length < 6) {
                    return 'Senha deve ter maios que 6 caracteres.';
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _authFormData.isLogin ? 'Entrar' : 'Cadastrar',
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _authFormData.toggleAuthMode();
                  });
                },
                child: Text(
                  _authFormData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possuí conta?',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
