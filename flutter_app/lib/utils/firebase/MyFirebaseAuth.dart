import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<bool> signInWithEmail(String email, String password) async {
    bool signInSuccess = false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      signInSuccess = userCredential.user != null;
    } catch (exception) {}
    return signInSuccess;
  }

  static Future<bool> loginWithEmail(String email, String password) async {
    bool isAuthenticate = false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      isAuthenticate = userCredential.user != null;
    } catch (exception) {}
    return isAuthenticate;
  }

  static Future<bool> signInWithGoogle() async {
    bool isAuthenticate = false;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleSignInAccount.authentication;
    final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    try {
      final UserCredential userCredential =
      await firebaseAuth.signInWithCredential(credentials);
      isAuthenticate = userCredential != null;
    } catch (exception) {}

    return isAuthenticate;
  }

  static Future<void> signOutWithGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (exception) {}
  }

  static bool userLogged() {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser != null;
  }
}
