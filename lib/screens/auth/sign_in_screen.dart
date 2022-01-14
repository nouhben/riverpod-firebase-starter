import 'package:alert_dialogs/alert_dialogs.dart';
import 'package:firebase_riverpod_architecture/screens/auth/sign_up_screen.dart';
import 'package:firebase_riverpod_architecture/screens/top_level_providers.dart';
import 'package:firebase_riverpod_architecture/shared/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_in_view_model.dart';
import 'widgets/auth_form.dart';

final signInModelProvider = ChangeNotifierProvider<SignInViewModel>(
  (ref) => SignInViewModel(authService: ref.watch(firebaseAuthServiceProvider)),
);

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInModel = ref.watch(signInModelProvider);
    ref.listen<SignInViewModel>(
      signInModelProvider,
      (_, model) async {
        if (model.error != null) {
          await showExceptionAlertDialog(
            context: context,
            title: Strings.signInFailed,
            exception: model.error,
          );
        }
      },
    );
    return SignInScreenContent(
      viewModel: signInModel,
      title: 'Sign in',
    );
  }
}

class SignInScreenContent extends StatelessWidget {
  const SignInScreenContent({
    Key? key,
    required this.viewModel,
    required this.title,
  }) : super(key: key);
  final SignInViewModel viewModel;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: 600.0,
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text('Register a new account'),
                ),
                if (viewModel.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                const SizedBox(height: 10.0),
                Expanded(
                  child: AuthenticationForm(
                    title: 'Sign in',
                    authenticate: viewModel.isLoading
                        ? null
                        : viewModel.signInEmailPassword,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
