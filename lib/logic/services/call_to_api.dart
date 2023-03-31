import 'dart:convert';
import 'dart:developer';

//import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'package:weather_app/constants/api_key.dart';

import 'package:weather_app/logic/models/weather_model.dart';

class CallToApi {
  Future<WeatherModel> callWeatherAPi(bool current, String cityName) async {
    try {
      Position currentPosition = await getCurrentPosition();

      if (current) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude);
        //  61.0587,
        //28.1887);

        Placemark place = placemarks[0];
        //cityName = 'london'; --> löysi säätiedot logi tulostukseen, mutta heittää errorin
        cityName = place.locality!;
      }

      var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
          {'q': cityName, "units": "metric", "appid": apiKey});
      final http.Response response = await http.get(url);
      log(response.body.toString());
      log("*********TESTAAN TOIMIIKO ********************");
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        return WeatherModel.fromMap(decodedJson, String: null);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      //throw Exception('Failed to load weather data');
      return Future.error('Unable to get location');
      //cityName = 'london';
      //current = true;
      //throw const CityNotFoundException();
      
    }
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}

class CityNotFoundException implements Exception {
    const CityNotFoundException() : super();

}

