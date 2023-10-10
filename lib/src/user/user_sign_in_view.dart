import 'package:flutter/material.dart';
import 'package:kirgu_employee/src/user/user_controller.dart';

class UserSignIn extends StatefulWidget {
  const UserSignIn({super.key, required this.userController});

  static const routeName = "/sign_in";

  final UserController userController;

  @override
  State<UserSignIn> createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
            ),
            TextField(
              controller: passwordController,
            ),
            ElevatedButton(
              onPressed: () {
                widget.userController
                    .signIn(usernameController.text, passwordController.text);
              },
              child: const Text("sign in"),
            )
          ],
        ),
      ),
    );
  }
}
