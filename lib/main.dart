import 'package:flutter/material.dart';

import 'package:weather_app/view/weather_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather_app',
      
      debugShowCheckedModeBanner: false, //Debug-bannerin piilotus
      theme: ThemeData(
        primarySwatch: Colors.amber, //color: Color(0xffffb56b) MIKSI EI TOIMI?
      ),
      home: WeatherPage(),
    );
  }
}
