import 'package:flutter/material.dart';
import 'package:marvelpedia/core/models/usuario_app.dart';
import 'package:marvelpedia/core/services/auth_service.dart';
import 'package:marvelpedia/pages/auth_page.dart';
import 'package:marvelpedia/pages/heroes_page.dart';
import 'package:marvelpedia/pages/loading_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsuarioApp?>(
      stream: AuthService().userChanges,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          return snapshot.hasData ? const HeroesPage() : const AuthPage();
        }
      },
    );
  }
}
