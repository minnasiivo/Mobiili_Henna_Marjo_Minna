import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:weather_app/logic/models/weather_model.dart';

class FirebaseHelper {
  final DatabaseReference _weatherModelRef =
      FirebaseDatabase.instance.ref().child('weathers');

  void saveWeather(WeatherModel weather) {
    weather.userid = FirebaseAuth.instance.currentUser!.uid;
    _weatherModelRef.push().set(weather.toJson());
  }

  void UpdateWeatherItem(WeatherModel item) {
    if (item.fbid != null) {
      _weatherModelRef.child(item.fbid.toString()).update(item.toJson());
    }
  }

  void DeleteItem(WeatherModel item) {
    if (item.fbid != null) {
      _weatherModelRef.child(item.fbid.toString()).remove();
    }
  }

  Future<List<WeatherModel>> getData() async {
    List<WeatherModel> weathers = [];

    DatabaseEvent event = await _weatherModelRef.once();
    var snapshot = event.snapshot;

    for (var child in snapshot.children) {
      WeatherModel weather =
          WeatherModel.fromJson(child.value as Map<dynamic, dynamic>);
      weather.fbid = child.key;
      weathers.add(weather);
    }
    return weathers;
  }
}
