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
  // CloseDialog? _closeDilogHandle;

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
          // final closeDialog = _closeDilogHandle;
          // if (!state.loading && closeDialog != null) {
          //   closeDialog();
          //   _closeDilogHandle = null;
          // } else if (state.loading && closeDialog == null) {
          //   _closeDilogHandle = loadingDialog(context, 'Loading...');
          // }
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
        body: Column(
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
                // try {
                final email = _emailController.text;
                final password = _passwordController.text;
                // final user = await AuthService.firebase().logIn(
                //   email: email,
                //   password: password,
                // );
                // if (context.mounted) {
                context.read<AuthBloc>().add(
                      AuthEventLogginIn(
                        email: email,
                        password: password,
                      ),
                    );
                // }
              },
              //   //Checking if the context is still on the screen or still alive
              // if (context.mounted) {
              //   //checking if user's emailVerified or not
              //   if (user.isEmailVerified) {
              //     Navigator.of(context).pushNamedAndRemoveUntil(
              //       notesRoute,
              //       (route) => false,
              //     );
              //   } else {
              //     Navigator.of(context).pushNamedAndRemoveUntil(
              //       emailVerificationRoute,
              //       (route) => false,
              //     );
              //   }
              // }
              //checking FirebaseAuthException errors
              //   } on InvalidEmailAuthException {
              //     if (context.mounted) {
              //       await showErrorDialog(context, "Invalid Email");
              //     }
              //   } on InvalidCredentialsAuthException {
              //     if (context.mounted) {
              //       await showErrorDialog(context, "Invalid Credentials");
              //     }
              //   } on ChannelErrorAuthException {
              //     if (context.mounted) {
              //       await showErrorDialog(context, "Something is missing");
              //     }
              //   } on GenericAuthException {
              //     if (context.mounted) {
              //       await showErrorDialog(context, "Something went wrong");
              //     }
              //   }
              // },
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventMoveToRegister());
              },
              child: const Text("Not Registered Yet! Register Now."),
            ),
          ],
        ),
      ),
    );
  }
}
