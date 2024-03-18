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
        title: const Text(
          "Verify Your Email",
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(136, 171, 142, 100.0)),
                    onPressed: () async {
                      context
                          .read<AuthBloc>()
                          .add(const AuthEventSendEmailVerification());
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Send Verification Email",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Restart Application Now. Press the button below",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          const Color.fromRGBO(136, 171, 142, 100.0),
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEventLogginOut());
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Restart",
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
        ],
      ),
    );
  }
}
