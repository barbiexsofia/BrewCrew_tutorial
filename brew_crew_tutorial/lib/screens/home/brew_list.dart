import 'package:brew_crew_tutorial/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brewNotifier = Provider.of<BrewNotifier>(context);

    final querySnapshot = brewNotifier.brewsSnapshot;

    // Check if QuerySnapshot is null
    if (querySnapshot == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final docs = querySnapshot.docs;

    // Print data for each document
    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>?;
      print(data);
    }

    return docs.isEmpty
        ? const Center(child: Text('No brews available.'))
        : ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>?;
              return ListTile(
                title: Text(data?['name'] ?? 'No name'),
                subtitle:
                    Text('Takes ${data?['sugars'] ?? 'unknown'} sugar(s).'),
              );
            },
          );
  }
}
