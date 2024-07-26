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

    final brews = brewNotifier.brews; // Get the list of Brew objects

    // Print data for each Brew
    brews.forEach((brew) {
      print(brew.name);
      print(brew.strength);
      print(brew.sugars);
    });

    return brews.isEmpty
        ? const Center(child: Text('No brews available.'))
        : ListView.builder(
            itemCount: brews.length,
            itemBuilder: (context, index) {
              final brew = brews[index];
              return ListTile(
                title: Text(brew.name),
                subtitle: Text(
                    'Takes ${brew.sugars} sugar(s). Strength: ${brew.strength}'),
              );
            },
          );
  }
}
