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

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      _currentUser = _userFromFirebaseUser(user);
      notifyListeners();
      return _currentUser;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  // Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      _currentUser = _userFromFirebaseUser(user);
      notifyListeners();
      return _currentUser;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  // Sign in anonimously
  Future<AppUser?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      _currentUser = _userFromFirebaseUser(user);
      notifyListeners();
      return _currentUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }
}
