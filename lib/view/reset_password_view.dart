import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/services/auth/bloc/auth_bloc.dart';
import 'package:my_notes/services/auth/bloc/auth_event.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(136, 171, 142, 100.0),
        title: const Text(
          'Reset Your Password',
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
              bottomRight: Radius.circular(25.0)),
        ),
        elevation: 0.00,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              autocorrect: false,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(242, 241, 235, 100),
                hintText: 'Enter your email here...',
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
                    color: Color.fromRGBO(136, 171, 142, 100.0),
                  ),
                ),
              ),
              cursorColor: const Color.fromRGBO(136, 171, 142, 100.0),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(136, 171, 142, 100.0),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(
                        AuthEventSendResetPasswordEmail(
                          email: _controller.text,
                        ),
                      );
                },
                child: const Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Send email to change password',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(136, 171, 142, 100.0),
              ),
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogginOut());
              },
              child: const Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  'Go, Back',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
