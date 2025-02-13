import 'package:brew_crew_tutorial/firebase_options.dart';
import 'package:brew_crew_tutorial/services/auth_notifier.dart';
import 'package:brew_crew_tutorial/screens/wrapper.dart';
import 'package:brew_crew_tutorial/services/database.dart';
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
    return ChangeNotifierProvider<AuthNotifier>(
      create: (_) => AuthNotifier(),
      child: Consumer<AuthNotifier>(
        builder: (context, authNotifier, _) {
          final user = authNotifier.currentUser;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => AuthNotifier(),
              ),
              if (user != null)
                ChangeNotifierProvider(
                  create: (_) => UserNotifier(
                    databaseService: DatabaseService(uid: user.uid),
                  ),
                ),
              if (user != null)
                ChangeNotifierProvider(
                  create: (_) => BrewNotifier(
                    databaseService: DatabaseService(uid: user.uid),
                  ),
                ),
            ],
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
            ),
          );
        },
      ),
    );
  }
}
