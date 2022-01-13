import 'package:firebase_riverpod_architecture/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const emailPasswordSignInPage = '/email-password-sign-in-page';
  static const editJobPage = '/edit-job-page';
  static const entryPage = '/entry-page';
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    // switch (settings.name) {
    //   case AppRoutes.emailPasswordSignInPage:
    //     return MaterialPageRoute<dynamic>(
    //       builder: (_) => EmailPasswordSignInPage.withFirebaseAuth(firebaseAuth,
    //           onSignedIn: args as void Function()),
    //       settings: settings,
    //       fullscreenDialog: true,
    //     );
    //   case AppRoutes.editJobPage:
    //     return MaterialPageRoute<dynamic>(
    //       builder: (_) => EditJobPage(job: args as Job?),
    //       settings: settings,
    //       fullscreenDialog: true,
    //     );
    //   case AppRoutes.entryPage:
    //     final mapArgs = args as Map<String, dynamic>;
    //     final job = mapArgs['job'] as Job;
    //     final entry = mapArgs['entry'] as Entry?;
    //     return MaterialPageRoute<dynamic>(
    //       builder: (_) => EntryPage(job: job, entry: entry),
    //       settings: settings,
    //       fullscreenDialog: true,
    //     );
    //   default:
    //     // TODO: Throw
    //     return null;
    // }
    throw UnimplementedError();
  }
}
