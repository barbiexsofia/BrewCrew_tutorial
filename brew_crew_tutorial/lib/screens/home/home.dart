import 'package:brew_crew_tutorial/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  //Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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
              await _auth.signOut();
              print('succesfully logged out!');
            },
            label: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
