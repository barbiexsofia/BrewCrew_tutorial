import 'package:brew_crew_tutorial/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  AppUser? _userFromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser> get user {
    // In the new library version, onAuthStateChange is deprecated and authStateChanges is now a method, so you need to put () after it.
    // ChatGPT gave me the following corrected version of the tutorial snippet:
    return _auth
        .authStateChanges()
        .map(_userFromFirebaseUser)
        .where((appUser) => appUser != null)
        .cast<AppUser>(); // Cast the stream to the correct type
  }

  // sign in anon
  Future signInAnon() async {
    try {
      // AuthResult is deprecated, use UserCredential
      UserCredential result = await _auth.signInAnonymously();
      // FirebaseUser is deprecated, use User
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // sign in with email and password

  // register with email and password

  // sign out
}
