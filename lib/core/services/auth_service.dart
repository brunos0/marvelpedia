import 'dart:io';
//import 'package:chat/core/models/chat_user.dart';
//import 'package:chat/core/services/auth/auth_firebase_service.dart';
import 'package:marvelpedia/core/models/usuario_app.dart';
import 'package:marvelpedia/core/services/auth_firebase_service.dart';
//import 'package:chat/core/services/auth/auth_mock_service.dart';

abstract class AuthService {
  factory AuthService() {
    // return AuthMockService();
    return AuthFirebaseService();
  }

  Stream<UsuarioApp?> get userChanges;

  Future<void> signup(
    String nome,
    String email,
    String password,
    //File image,
  );
  Future<void> login(
    String email,
    String password,
  );
  Future<void> logout();
}
