import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kirgu_employee/src/user/user_provider.dart';
import 'package:kirgu_employee/src/wta_event/wta_event_list.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  static const routeName = "/sign_in";

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
    return Consumer(
      builder: (context, ref, child) {
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
                const SizedBox(
                  height: 8.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await ref.read(userRepositoryProvider.notifier).signIn(
                        usernameController.text, passwordController.text);
                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const EventListView(),
                        ),
                      );
                    }
                  },
                  child: const Text("sign in"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
