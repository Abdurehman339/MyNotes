import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:my_notes/Utilities/dialogs/error_dialog.dart";
import "package:my_notes/services/auth/auth_exception.dart";
import "package:my_notes/services/auth/bloc/auth_bloc.dart";
import "package:my_notes/services/auth/bloc/auth_event.dart";
import "package:my_notes/services/auth/bloc/auth_state.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid Email');
          } else if (state.exception is InvalidCredentialsAuthException) {
            await showErrorDialog(context, 'Invalid Credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Something Went Wrong');
          } else if (state.exception is ChannelErrorAuthException) {
            await showErrorDialog(context, 'Channel Error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                autocorrect: false,
                enableSuggestions: false,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter password here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  context.read<AuthBloc>().add(
                        AuthEventLogginIn(
                          email: email,
                          password: password,
                        ),
                      );
                },
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventMoveToRegister());
                },
                child: const Text("Not Registered Yet! Register Now."),
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<AuthBloc>()
                      .add(const AuthEventMoveToResetPassword());
                },
                child: const Text('Forgot password!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
