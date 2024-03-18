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
          title: const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          titleSpacing: 20.0,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
          ),
          elevation: 0.00,
          backgroundColor: const Color.fromRGBO(136, 171, 142, 100.0),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: TextField(
                  controller: _emailController,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(242, 241, 235, 100),
                    hintText: 'Enter your email',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(175, 200, 173, 100.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(175, 200, 173, 100.0),
                      ),
                    ),
                  ),
                  cursorColor: const Color.fromRGBO(136, 171, 142, 100.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: TextField(
                  controller: _passwordController,
                  autocorrect: false,
                  enableSuggestions: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(242, 241, 235, 100),
                    hintText: 'Enter password here',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(175, 200, 173, 100.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(175, 200, 173, 100.0),
                      ),
                    ),
                  ),
                  cursorColor: const Color.fromRGBO(136, 171, 142, 100.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  right: 10.0,
                  left: 10.0,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor:
                          const Color.fromRGBO(136, 171, 142, 100.0)),
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
                  child: const Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  right: 10.0,
                  left: 10.0,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(136, 171, 142, 100.0),
                  ),
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventMoveToRegister());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      "Not Registered Yet! Register Now.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 10.0,
                  right: 10.0,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(136, 171, 142, 100.0),
                  ),
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventMoveToResetPassword());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      'Forgot password!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
