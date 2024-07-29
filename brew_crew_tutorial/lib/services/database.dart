import 'package:brew_crew_tutorial/models/brew.dart';
import 'package:brew_crew_tutorial/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// DatabaseService remains mostly unchanged
class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(String name, String sugars, int strength) async {
    return await brewCollection.doc(uid).set({
      'name': name,
      'sugars': sugars,
      'strength': strength,
    });
  }

  Future<UserData> getUserData() async {
    DocumentSnapshot snapshot = await brewCollection.doc(uid).get();
    return UserData(
      uid: uid,
      name: snapshot['name'] ?? '',
      sugars: snapshot['sugars'] ?? '',
      strength: snapshot['strength'] ?? 0,
    );
  }

/*   // UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot['name'],
      sugars: snapshot['sugars'],
      strength: snapshot['strength'],
    );
  } */

/*   // Brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    // ".documents" is deprecated, use ".docs"
    return snapshot.docs.map((doc) {
      // Safely cast the document data to a Map<String, dynamic>?
      final data = doc.data() as Map<String, dynamic>?;

      return Brew(
        name: data?['name'] ?? '',
        strength: data?['strength'] ?? 0,
        sugars: data?['sugars'] ?? '0',
      );
    }).toList();
  } */

  // fetch brews once
  Future<List<Brew>> fetchBrews() async {
    // Fetch the snapshot
    QuerySnapshot snapshot = await brewCollection.get();
    // Convert the snapshot to a list of Brew objects
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Brew(
        name: data['name'] ?? '',
        strength: data['strength'] ?? 0,
        sugars: data['sugars'] ?? '0',
      );
    }).toList();
  }

/*   // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  } */
}

class UserNotifier extends ChangeNotifier {
  final DatabaseService databaseService;
  UserData? _userData;

  UserNotifier({required this.databaseService}) {
    _fetchUserData();
  }

  UserData? get userData => _userData;

  Future<void> _fetchUserData() async {
    _userData = await databaseService.getUserData();
    notifyListeners();
  }

  Future<void> updateUserData(String name, String sugars, int strength) async {
    await databaseService.updateUserData(name, sugars, strength);
    _fetchUserData(); // Fetch updated user data after update
  }
}

// BrewNotifier handles the brew-related state
class BrewNotifier extends ChangeNotifier {
  final DatabaseService databaseService;
  List<Brew> _brews = [];

  BrewNotifier({required this.databaseService}) {
    _fetchBrews();
  }

  List<Brew> get brews => _brews; // Getter for the list of Brew objects

  Future<void> _fetchBrews() async {
    _brews = await databaseService.fetchBrews();
    notifyListeners();
  }

  Future<void> updateUserData(String sugars, String name, int strength) async {
    await databaseService.updateUserData(name, sugars, strength);
    _fetchBrews(); // Refresh the list of brews after updating
  }
}
