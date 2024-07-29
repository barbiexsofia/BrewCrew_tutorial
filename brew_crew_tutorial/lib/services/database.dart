import 'package:brew_crew_tutorial/models/brew.dart';
import 'package:brew_crew_tutorial/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    // ".document()" is deprecated. Use .doc()
    // ".setData()" is deprecated. Use .set()
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot['name'],
      sugars: snapshot['sugars'],
      strength: snapshot['strength'],
    );
  }

  // Brew list from snapshot
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
  }

  // fetch brews once
  Future<List<Brew>> fetchBrews() async {
    // Fetch the snapshot
    QuerySnapshot snapshot = await brewCollection.get();
    // Convert the snapshot to a list of Brew objects
    return _brewListFromSnapshot(snapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}

class BrewNotifier extends ChangeNotifier {
  final DatabaseService databaseService;
  List<Brew> _brews = []; // Holds the list of Brew objects

  BrewNotifier({required this.databaseService}) {
    _fetchBrews();
  }

  List<Brew> get brews => _brews; // Getter for the list of Brew objects

  Future<void> _fetchBrews() async {
    _brews = await databaseService.fetchBrews();
    notifyListeners(); // Notify listeners when data is fetched
  }

  Future<void> updateUserData(String sugars, String name, int strength) async {
    await databaseService.updateUserData(sugars, name, strength);
    _fetchBrews(); // Refresh the data after update
  }
}
