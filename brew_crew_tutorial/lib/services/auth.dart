import 'package:brew_crew_tutorial/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

/* class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  AppUser? _userFromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // sign in anon
  Future<AppUser?> signInAnon() async {
    try {
      // AuthResult is deprecated, use UserCredential
      UserCredential result = await _auth.signInAnonymously();
      // FirebaseUser is deprecated, use User
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // sign in with email and password

  // register with email and password

  // sign out
  Future<void> signOut() async {
    try {
      print("logged out");
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
} */
