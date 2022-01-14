import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_riverpod_architecture/screens/auth/sign_in_screen.dart';
import 'package:firebase_riverpod_architecture/screens/auth_widget.dart';
import 'package:firebase_riverpod_architecture/screens/onboarding/onboarding_view_model.dart';
import 'package:firebase_riverpod_architecture/screens/top_level_providers.dart';
import 'package:firebase_riverpod_architecture/services/shared_preferences_service.dart';
import 'package:firebase_riverpod_architecture/shared/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(
          SharedPreferencesService(sharedPreferences: sharedPreferences),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final auth = ref.watch(firebaseAuthServiceProvider);
    return MaterialApp(
      title: 'Firebase Riverpod Architecture',
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
      home: AuthWidget(
        nonSignedInBuilder: (context) => Consumer(
          builder: (context, ref, _) {
            final didCompleteOnboarding =
                ref.watch(onboardingViewModelProvider);
            return didCompleteOnboarding
                ? const OnboardingScreen()
                : const SignInScreen();
          },

          /// TODO: fix the auth when the user choses to register maybe add a wrapper with a ValueProvider
        ),
        signedInBuilder: (context) => const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);
  void _logout(WidgetRef ref) async {
    final authService = ref.read(firebaseAuthServiceProvider);
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 0.0,
        actions: [
          TextButton.icon(
            onPressed: () => _logout(ref),
            icon: const Icon(Icons.logout),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
