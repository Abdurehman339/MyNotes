import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/Utilities/dialogs/error_dialog.dart';
import 'package:my_notes/services/auth/auth_exception.dart';
import 'package:my_notes/services/auth/bloc/auth_bloc.dart';
import 'package:my_notes/services/auth/bloc/auth_event.dart';
import 'package:my_notes/services/auth/bloc/auth_state.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        if (state is AuthStateRegistering) {
          if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email Already In Use');
          }
          if (state.exception is WeakPasswordAuthException) {
            // ignore: use_build_context_synchronously
            await showErrorDialog(context, 'Weak Password');
          }
          if (state.exception is InvalidEmailAuthException) {
            // ignore: use_build_context_synchronously
            await showErrorDialog(context, 'Email is not valid');
          }
          if (state.exception is ChannelErrorAuthException) {
            // ignore: use_build_context_synchronously
            await showErrorDialog(context, 'Channel Error');
          }
          if (state.exception is GenericAuthException) {
            // ignore: use_build_context_synchronously
            await showErrorDialog(context, 'Something Went Wrong');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
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
                  hintText: "Enter email here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                    hintText: "Enter password here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )),
              ),
              TextButton(
                onPressed: () async {
                  // try {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  context.read<AuthBloc>().add(
                        AuthEventRegister(
                          email: email,
                          password: password,
                        ),
                      );
                },
                child: const Text("Register"),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogginOut());
                },
                child: const Text("Already Register! Login Now."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
