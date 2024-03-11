import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/services/auth/bloc/auth_bloc.dart';
import 'package:my_notes/services/auth/bloc/auth_event.dart';

class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Your Email"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              bottom: 100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                const Text(
                  "Veirfy Your Email Now",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "we've sent you an email. Please verify your email from there!",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                const Text(
                  "Didn't get email yet. Press the button below",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventSendEmailVerification());
                  },
                  child: const Text("Send Verification Email"),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                ),
                const Text(
                  "Restart Application Now. Press the button below",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogginOut());
                    // AuthService.firebase().logOut();
                    // Navigator.pushNamedAndRemoveUntil(
                    //   context,
                    //   loginRoute,
                    //   (route) => false,
                    // );
                  },
                  child: const Text("Restart"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
