import 'package:marvelpedia/core/models/usuario_app.dart';
import 'package:marvelpedia/core/services/auth_firebase_service.dart';

abstract class AuthService {
  factory AuthService() {
    return AuthFirebaseService();
  }

  Stream<UsuarioApp?> get userChanges;

  Future<void> signup(
    String nome,
    String email,
    String password,
  );

  Future<void> login(
    String email,
    String password,
  );
  Future<void> logout();
}
