//import 'package:flutter/material.dart';

class WeatherModel {
  final String temp;
  final String city;
  final String desc;
  final String icon;

  WeatherModel.fromMap(Map<String, dynamic> json, {required String})
      : temp = json['main']['temp'].toString(),
        city = json['name'],
        desc = json['weather'][0]['description'],
        icon = json['weather'][0]['icon'];
}
