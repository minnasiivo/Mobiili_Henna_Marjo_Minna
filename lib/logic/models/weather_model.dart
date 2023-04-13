//import 'package:flutter/material.dart';

import 'dart:developer';

class WeatherModel {
  String temp;
  String city;
  String country;
  String desc;
  String icon;
  int id = -1;
  String? fbid;
  DateTime date = DateTime.now();
  String? userid;
  String? pictureURL;

  WeatherModel({
    this.id = -1,
    required this.temp,
    required this.city,
    required this.country,
    required this.desc,
    required this.icon,
    required this.date,
    this.fbid,
    this.userid,
    this.pictureURL =
        'https://firebasestorage.googleapis.com/v0/b/weatherapp-7c11d.appspot.com/o/CAP7682421739371229962.jpg?alt=media&token=cac001e6-a27f-4c6e-87b2-a5ccdffced1d',
  });

// Luetaan openweatherAPIsta säätiedot:
  WeatherModel.fromMap(Map<String, dynamic> json, {required dynamic string})
      : temp = json['main']['temp']
            .round()
            .toString(), //Miten saa yhden desimaalin tarkkuudella?
        city = json['name'],
        country = json['sys']['country'],
        desc = json['weather'][0]['description'],
        icon = json['weather'][0]['icon'];

  Map<String, dynamic> toMap() {
    return {
      'temp': this.temp,
      'city': this.city,
      'country': this.country,
      'desc': this.desc,
      'icon': this.icon,
      //'date': date.millisecondsSinceEpoch,
    };
  }

// Luetaan firebasesta säätieto json-muodossa
  WeatherModel.fromJson(Map<dynamic, dynamic> json)
      : temp = json['temp'] as String,
        city = json['city'] as String,
        country = json['country'] as String,
        desc = json['desc'] as String,
        icon = json['icon'] as String,
        userid = json['userid'] as String,
        date = DateTime.parse(json['date'] as String),
        pictureURL = json['pictureURL'] as String;

// Kirjoitetaan säätieto firebaseen jsonina
  Map<String, dynamic> toJson() => <String, dynamic>{
        'temp': temp,
        'city': city,
        'country': country,
        'desc': desc,
        'icon': icon,
        'date': date.toString(),
        'userid': userid,
        'pictureURL': pictureURL,
      };
}
