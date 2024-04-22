import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:marvelpedia/core/models/usuario_app.dart';
import 'package:marvelpedia/core/services/auth_service.dart';

class AuthFirebaseService implements AuthService {
  static UsuarioApp? _currentUser;

  static final _userStream = Stream<UsuarioApp?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : await _toChatUser(user);

      controller.add(_currentUser);
    }
  });

  UsuarioApp? get currentUser {
    return _currentUser;
  }

  @override
  Stream<UsuarioApp?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signup(String name, String email, String password) async {
    final signup = await Firebase.initializeApp(
      name: 'userSignup',
      options: Firebase.app().options,
    );

    final auth = FirebaseAuth.instanceFor(app: signup);

    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await signup.delete();
  }

  @override
  Future<void> login(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  static Future<UsuarioApp> _toChatUser(User user, [String? name]) async {
    return UsuarioApp(
      id: user.uid,
      nome: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
    );
  }
}
