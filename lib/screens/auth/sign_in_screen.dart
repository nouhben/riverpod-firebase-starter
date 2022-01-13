import 'package:firebase_riverpod_architecture/screens/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  void _signInAnonymously(
      {required BuildContext context, required WidgetRef ref}) async {
    try {
      final auth = ref.read(firebaseAuthServiceProvider);
      await auth.signInAnon();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sign in'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInAnonymously(context: context, ref: ref),
          child: const Text('Sign in'),
        ),
      ),
    );
  }
}
