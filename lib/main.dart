import 'package:flutter/material.dart';

import 'package:weather_app/view/weather_page.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:weather_app/view/weather_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var providers = [EmailAuthProvider()];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/mainpage',
      routes: {
        '/sign-in': (context) {
          return SignInScreen(
            providers: providers,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/mainpage');
              }),
            ],
          );
        },
        '/mainpage': (context) {
          return WeatherPage();
        },
      },
    );
  }
}
