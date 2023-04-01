//import 'package:flutter/material.dart';

class WeatherModel {
  int id = -1;
  String temp;
  String city;
  String country;
  String desc;
  String icon;

  WeatherModel({
    this.id = -1,
    required this.temp,
    required this.city,
    required this.country,
    required this.desc,
    required this.icon,
  });

  WeatherModel.fromMap(Map<String, dynamic> json, {required String})
      : temp = json['main']['temp']
            .toString(), //Miten saa yhden desimaalin tarkkuudella?
        city = json['name'],
        country = json['sys']['country'],
        desc = json['weather'][0]['description'],
        icon = json['weather'][0]['icon'];
}
