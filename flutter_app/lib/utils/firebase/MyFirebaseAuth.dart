import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<bool> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user != null;
    } catch (exception) {
      return false;
    }
  }

  static Future<bool> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user != null;
    } catch (exception) {
      return false;
    }

  }

  static Future<bool> loginWithGoogle() async {
    bool isAuthenticate = false;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if(googleSignInAccount != null) {
      final GoogleSignInAuthentication googleAuth =
      await googleSignInAccount.authentication;
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      try {
        final UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credentials);
        isAuthenticate = userCredential != null;
      } catch (exception) {
        return false;
      }
    }

    return isAuthenticate;
  }

  static void signOut({bool isRepeat = true}) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (exception) {
      if(isRepeat) {
        signOut(isRepeat: false);
      }
    }
  }

  static bool userLogged() {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser != null;
  }
}
