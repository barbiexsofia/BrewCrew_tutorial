import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_tutorial/models/user.dart';

class AuthNotifier extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AppUser? _currentUser;

  AuthNotifier() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  AppUser? get currentUser => _currentUser;

  Future<void> _onAuthStateChanged(User? user) async {
    _currentUser = _userFromFirebaseUser(user);
    notifyListeners();
  }

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<AppUser?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
