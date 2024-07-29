import 'package:brew_crew_tutorial/screens/home/brew_list.dart';
import 'package:brew_crew_tutorial/screens/home/settings_form.dart';
import 'package:brew_crew_tutorial/services/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    void showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        builder: (BuildContext context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: const SettingsForm(),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            onPressed: () async {
              await authNotifier.signOut();
              print('successfully logged out!');
            },
            label: const Text('Logout'),
          ),
          TextButton.icon(
            icon: const Icon(Icons.settings),
            label: const Text('Settings'),
            onPressed: () => showSettingsPanel(),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'), fit: BoxFit.cover)),
        child: const BrewList(),
      ),
    );
  }
}
