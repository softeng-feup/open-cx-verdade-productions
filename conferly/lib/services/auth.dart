import 'package:conferly/models/user.dart';
import 'package:conferly/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password).catchError((error) => print(error.code));

    if(result != null) {
      FirebaseUser firebaseUser = result.user;
//      MyApp.firebaseUser = firebaseUser;
//      return DatabaseService().getUser(firebaseUser.uid);
      User user =  await DatabaseService().getUser(firebaseUser.uid);
      MyApp.firebaseUser = user;
      return user;
    }

    return null;
  }

  // sign in with google
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn().catchError((error) => print(error.code));
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication.catchError((error) => print(error.code));
    final AuthResult result = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken)).catchError((error) => print(error.code));

    if(result != null) {
      FirebaseUser firebaseuser = result.user;
      DatabaseService db = DatabaseService();
      User user;
      if(await db.userExists(firebaseuser.uid)) {
        user = await db.getUser(firebaseuser.uid);
      } else {
        db.introduceUserData(firebaseuser.uid, firebaseuser.email, firebaseuser.displayName);
        user = User.defaultUser(firebaseuser.uid, firebaseuser.email, firebaseuser.displayName);
      }
      MyApp.firebaseUser = user;
      return user;
    }

    return null;
  }

  // register with email and password
  Future<User> registerWithEmailAndPassword(String email, String password, String name) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password).catchError((error) => print(error.code));

    if(result != null) {
      FirebaseUser firebaseUser = result.user;
//      MyApp.firebaseUser = firebaseUser;
      await DatabaseService().introduceUserData(firebaseUser.uid, email, name);
      User user =  await DatabaseService().getUser(firebaseUser.uid);
      MyApp.firebaseUser = user;
      return user;
    }

    return null;
  }

  Future<User> currentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    User u = _userFromFirebaseUser(user);
    MyApp.firebaseUser = u;
    return u;
  }

  // sign out
  void signOut() async {
    await _auth.signOut().catchError((error) => print(error.code));
    await _googleSignIn.signOut().catchError((error) => print(error.code));
  }
}