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

  WeatherModel({
    this.id = -1,
    required this.temp,
    required this.city,
    required this.country,
    required this.desc,
    required this.icon,
    required this.date,
  });

  WeatherModel.fromMap(Map<String, dynamic> json, {required dynamic string})
      : temp = json['main']['temp']
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
      'date': date.millisecondsSinceEpoch,
    };
  }

  WeatherModel.fromJson(Map<dynamic, dynamic> json)
      : temp = json['temp'] as String,
        city = json['city'] as String,
        country = json['country'] as String,
        desc = json['desc'] as String,
        icon = json['icon'] as String;
        //date = json['date'] as DateTime;
        

  Map<String, dynamic> toJson() => <String, dynamic>{
        'temp': temp,
        'city': city,
        'country': country,
        'desc': desc,
        'icon': icon,
        'date' : date,
      };
}
