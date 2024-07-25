import 'package:brew_crew_tutorial/screens/authenticate/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({required this.toggleView});

  //const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text('Sign in to BrewCrew'),
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              onPressed: () async {
                widget.toggleView();
                print('succesfully registered!');
              },
              label: const Text('Register'),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          /* child: ElevatedButton(
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
          ), */
          child: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  TextFormField(
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      print(email);
                      print(password);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                    ),
                    child: const Text('Sign in',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
