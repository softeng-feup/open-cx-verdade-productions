import 'package:conferly/models/user.dart';
import 'package:conferly/notifier/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future<bool> signInWithEmailAndPassword(String email, String password, AuthNotifier authNotifier) async {
    AuthResult result = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) => print(error.code));

    if(result != null) {
      FirebaseUser user = result.user;
      authNotifier.setUser(_userFromFirebaseUser(user));
      return true;
    }

    return false;
  }

  // sign in with google
  Future<bool> signInWithGoogle(AuthNotifier authNotifier) async {
    final GoogleSignInAccount googleUser = await _googleSignIn
        .signIn()
        .catchError((error) => print(error.code));
    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication.catchError((error) => print(error.code));
    final AuthResult result = await _auth
        .signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken))
        .catchError((error) => print(error.code));

    if(result != null) {
      FirebaseUser user = result.user;
      authNotifier.setUser(_userFromFirebaseUser(user));
      return true;
    }

    return false;
  }

  // register with email and password
  Future<bool> registerWithEmailAndPassword(String email, String password, String name, AuthNotifier authNotifier) async {
    AuthResult result = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((error) => print(error.code));

    if(result != null) {
      FirebaseUser user = result.user;
      authNotifier.setUser(_userFromFirebaseUser(user));
      return true;
    }

    return false;
  }

  // sign out
  void signOut(AuthNotifier authNotifier) async {
    await _auth.signOut().catchError((error) => print(error.code));
    await _googleSignIn.signOut().catchError((error) => print(error.code));
    authNotifier.setUser(null);
  }

}