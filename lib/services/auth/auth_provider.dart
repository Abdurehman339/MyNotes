import 'package:my_notes/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initializeApp();
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser?> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  AuthUser? get currentUser;
  Future<void> sendEmailVerification();
  Future<void> sendResetPasswordEmail({required String email});
}
