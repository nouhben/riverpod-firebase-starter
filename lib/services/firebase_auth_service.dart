import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_riverpod_architecture/services/auth_service.dart';

class FirebaseAuthService extends AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  /// User? _userFromFirebaseUser(User? firebaseUser) => firebaseUser;
  @override
  Stream<User?> get onAuthStateChanged => _firebaseAuth.authStateChanges();

  @override
  Future<void> signOut() async => _firebaseAuth.signOut();

  @override
  Future<User?> signInAnon() async {
    final result = await _firebaseAuth.signInAnonymously();
    return result.user;
  }

  @override
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  @override
  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  @override
  Future createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  void dispose() {}

  @override
  Future<void> sendRestPasswordEmail({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future signInWithApple() {
    throw UnimplementedError();
  }

  @override
  Future signInWithFacebook() {
    throw UnimplementedError();
  }

  @override
  Future signInWithGoogle() {
    throw UnimplementedError();
  }
}
