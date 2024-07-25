import 'package:brew_crew_tutorial/firebase_options.dart';
import 'package:brew_crew_tutorial/models/user.dart';
import 'package:brew_crew_tutorial/screens/wrapper.dart';
import 'package:brew_crew_tutorial/services/auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      catchError: (_, __) => null,
      value: AuthService().user,
      // Added initialData: User() as per stackoverflow, else it gives error
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
