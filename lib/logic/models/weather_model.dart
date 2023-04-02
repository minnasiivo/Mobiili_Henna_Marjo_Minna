//import 'package:flutter/material.dart';

import 'dart:developer';

class WeatherModel {
  String temp;
  String city;
  String country;
  String desc;
  String icon;
  int id = -1;

  WeatherModel({
    this.id = -1,
    required this.temp,
    required this.city,
    required this.country,
    required this.desc,
    required this.icon,
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
    };
  }
}
