import 'package:brew_crew_tutorial/screens/authenticate/auth_notifier.dart';
import 'package:brew_crew_tutorial/screens/home/home.dart';
import 'package:brew_crew_tutorial/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    final user = authNotifier.currentUser;

    print('Wrapper rebuild with user: ${user?.uid}');

    if (user == null) {
      print("Wrapper says: user is null");
      return Authenticate();
    } else {
      print("Wrapper says: user is not null!");
      return Home();
    }
  }
}
