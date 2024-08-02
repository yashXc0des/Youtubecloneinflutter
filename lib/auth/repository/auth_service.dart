import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authServiceProvider = Provider((ref) => AuthService(
  auth: FirebaseAuth.instance,
  googleSignIn: GoogleSignIn(),
));

class AuthService {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  AuthService({
    required this.auth,
    required this.googleSignIn,
  });

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? user = await googleSignIn.signIn();
      if (user == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await user.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await auth.signInWithCredential(credential);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: $e');
      throw Exception('Failed to sign in with Google: $e');
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to sign in with Google: $e');
    }
  }
}
