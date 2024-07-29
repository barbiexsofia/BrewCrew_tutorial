import 'package:brew_crew_tutorial/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_tutorial/services/database.dart';

class BrewList extends StatelessWidget {
  const BrewList({super.key});

  @override
  Widget build(BuildContext context) {
    final brewNotifier = Provider.of<BrewNotifier>(context);

    return brewNotifier.brews.isEmpty
        ? const Center(child: Text('No brews available.'))
        : ListView.builder(
            itemCount: brewNotifier.brews.length,
            itemBuilder: (context, index) {
              return BrewTile(brew: brewNotifier.brews[index]);
            },
          );
  }
}
