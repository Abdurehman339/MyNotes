import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventLogginIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogginIn({
    required this.email,
    required this.password,
  });
}

class AuthEventMoveToRegister extends AuthEvent {
  const AuthEventMoveToRegister();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  const AuthEventRegister({
    required this.email,
    required this.password,
  });
}

class AuthEventLogginOut extends AuthEvent {
  const AuthEventLogginOut();
}

class AuthEventMoveToResetPassword extends AuthEvent {
  const AuthEventMoveToResetPassword();
}

class AuthEventSendResetPasswordEmail extends AuthEvent {
  final String? email;
  const AuthEventSendResetPasswordEmail({required this.email});
}
