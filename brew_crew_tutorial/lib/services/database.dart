import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier {
  final String? uid;
  DatabaseService({this.uid});

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

  // fetch brews once
  Future<QuerySnapshot> fetchBrews() async {
    return await brewCollection.get();
  }
}

class BrewNotifier extends ChangeNotifier {
  final DatabaseService databaseService;
  QuerySnapshot? _brewsSnapshot; // Holds the query result

  BrewNotifier({required this.databaseService}) {
    _fetchBrews();
  }

  QuerySnapshot? get brewsSnapshot => _brewsSnapshot; // Getter for snapshot

  Future<void> _fetchBrews() async {
    _brewsSnapshot = await databaseService.fetchBrews();
    notifyListeners(); // Notify listeners when data is fetched
  }

  Future<void> updateUserData(String sugars, String name, int strength) async {
    await databaseService.updateUserData(sugars, name, strength);
    _fetchBrews(); // Refresh the data after update
  }
}
