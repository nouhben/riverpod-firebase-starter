import 'package:alert_dialogs/alert_dialogs.dart';
import 'package:firebase_riverpod_architecture/screens/top_level_providers.dart';
import 'package:firebase_riverpod_architecture/shared/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_up_view_model.dart';
import 'widgets/auth_form.dart';

final signUpModelProvider = ChangeNotifierProvider.autoDispose<SignUpViewModel>(
  (ref) => SignUpViewModel(
    authService: ref.watch(firebaseAuthServiceProvider),
  ),
);

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpModel = ref.watch(signUpModelProvider);
    ref.listen<SignUpViewModel>(
      signUpModelProvider,
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
    return SignUpScreenContent(
      viewModel: signUpModel,
      title: 'Register',
    );
  }
}

class SignUpScreenContent extends StatelessWidget {
  const SignUpScreenContent({
    Key? key,
    required this.viewModel,
    required this.title,
  }) : super(key: key);
  final SignUpViewModel viewModel;
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
                if (viewModel.isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  ),
                Expanded(
                  child: AuthenticationForm(
                    title: 'Register',
                    authenticate: viewModel.isLoading
                        ? null
                        : viewModel.registerEmailPassword,
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
