import 'package:brew_crew_tutorial/models/user.dart';
import 'package:brew_crew_tutorial/services/auth_notifier.dart';
import 'package:brew_crew_tutorial/shared/constants.dart';
import 'package:brew_crew_tutorial/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({required this.toggleView, super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // text field state
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    return loading
        ? const Loading()
        : Scaffold(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'E-mail'),
                      validator: (val) => val!.isEmpty || !val.contains("@")
                          ? 'Enter an email'
                          : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await authNotifier
                              .signInWithEmailAndPassword(email, password);
                          if (result is! AppUser) {
                            try {
                              // the returned Firebase error object has two keys: code and message.
                              error = result.message;
                            } catch (e) {
                              // if the HTTP API call failed unpredictably
                              print(e);
                              error =
                                  'Couldn\'t sign in with those credentials.';
                            }
                            setState(() {
                              error = error;
                              loading = false;
                            });
                          } // no need for an else, because if else --> it automatically signs the user in.
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[400],
                      ),
                      child: const Text('Sign in',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 12.0),
                    Text(error, style: const TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ),
          );
  }
}
