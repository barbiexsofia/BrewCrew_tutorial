import 'package:brew_crew_tutorial/services/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          // FlatButton is deprecated, used TextButton
          TextButton.icon(
            icon: const Icon(Icons.person),
            onPressed: () async {
              await authNotifier.signOut();
              print('succesfully logged out!');
            },
            label: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
