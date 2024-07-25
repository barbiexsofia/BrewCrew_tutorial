//import 'package:brew_crew_tutorial/screens/home/home.dart';
import 'package:brew_crew_tutorial/models/user.dart';
import 'package:brew_crew_tutorial/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    print("pippo:");
    print(user);
    // return either Home or Authenticate widget;
    return Authenticate();
  }
}
