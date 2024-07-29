import 'package:brew_crew_tutorial/models/user.dart';
import 'package:brew_crew_tutorial/services/auth_notifier.dart';
import 'package:brew_crew_tutorial/services/database.dart';
import 'package:brew_crew_tutorial/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_tutorial/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    // When I get to settings_form, I know FOR SURE the user will never be null, so I add the null assertion operator "!":
    final user = authNotifier.currentUser!;

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        // Here, "snapshot" refers to ANY type of data coming down the stream, it doesn't necessarily refer to the Firebase Snapshot!!:
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => (val == null || val.isEmpty)
                        ? 'Please enter a name'
                        : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField<String>(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugars = val as String),
                  ),
                  const SizedBox(height: 20.0),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  const SizedBox(height: 20.0),
                  //button
                  ElevatedButton(
                      onPressed: () async {
                        print(_currentName);
                        print(_currentSugars);
                        print(_currentStrength);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[400],
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
