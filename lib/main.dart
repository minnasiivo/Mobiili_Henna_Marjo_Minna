//import 'dart:developer';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/globals.dart';
import 'package:weather_app/logic/models/weather_list_manager.dart';

import 'package:weather_app/view/weather_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dbHelper.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) {
        var model = WeatherListManager();
        model.init();
        return model;
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var providers = [EmailAuthProvider()];

    return MaterialApp(
      debugShowCheckedModeBanner: false, //debug banneri pois näkyvistä
      theme: ThemeData(
        primarySwatch: Colors.amber,
        appBarTheme: AppBarTheme(
          color:Colors.amber)),
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
          return const WeatherPage();
        },
      },
    );
  }
}
