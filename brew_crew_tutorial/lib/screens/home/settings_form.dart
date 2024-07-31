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
    final user = authNotifier.currentUser!;

    final userNotifier = Provider.of<UserNotifier>(context);
    final brewNotifier = Provider.of<BrewNotifier>(context);
    // Add debug prints to understand what values are being used
    print("Current Sugars: $_currentSugars");
    print("User Data Sugars: ${userNotifier.userData?.sugars}");
    if (userNotifier.userData == null) {
      print("userNotifier.userData is null");
    }
    print(user.uid);

    return userNotifier.userData == null
        ? const Loading()
        : Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userNotifier.userData!.name,
                  decoration: textInputDecoration,
                  validator: (val) => (val == null || val.isEmpty)
                      ? 'Please enter a name'
                      : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                const SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userNotifier.userData!.sugars,
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
                  value: (_currentStrength ?? userNotifier.userData!.strength)
                      .toDouble(),
                  activeColor: Colors.brown[
                      _currentStrength ?? userNotifier.userData!.strength],
                  inactiveColor: Colors.brown[
                      _currentStrength ?? userNotifier.userData!.strength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _currentStrength = val.round()),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await userNotifier.updateUserData(
                        _currentName ?? userNotifier.userData!.name,
                        _currentSugars ?? userNotifier.userData!.sugars,
                        _currentStrength ?? userNotifier.userData!.strength,
                      );
                      await brewNotifier.updateUserData(
                        _currentSugars ?? userNotifier.userData!.sugars,
                        _currentName ?? userNotifier.userData!.name,
                        _currentStrength ?? userNotifier.userData!.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
  }
}
