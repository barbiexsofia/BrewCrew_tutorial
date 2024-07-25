import 'package:brew_crew_tutorial/screens/authenticate/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text('Sign in to BrewCrew'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: ElevatedButton(
            child: const Text('Sign in Anon'),
            onPressed: () async {
              dynamic result = await authNotifier.signInAnon();
              if (result == null) {
                print('error signing in');
              } else {
                print('sign in successful');
                print(result);
              }
            },
          ),
        ));
  }
}
