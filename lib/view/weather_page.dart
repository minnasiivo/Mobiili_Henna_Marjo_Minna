import 'dart:developer';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/logic/models/weather_model.dart';
import 'package:weather_app/logic/services/call_to_api.dart';
//import 'package:camera/camera.dart';

//import '../camera_page.dart';
import '../logic/models/weather_list_manager.dart';

import 'input_view.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<WeatherModel> getData(bool isCurrentCity, String cityName) async {
    log("Testi: " + isCurrentCity.toString() + cityName + _myData.toString());
    return await CallToApi().callWeatherAPi(isCurrentCity, cityName);
  }

  bool isFavourite = false;
  DateTime now = DateTime.now();

  TextEditingController textController = TextEditingController(text: "");
  Future<WeatherModel>? _myData;
  @override
  void initState() {
    setState(() {
      _myData = getData(true, "");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherListManager>(builder: (context, listManager, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(FirebaseAuth.instance.currentUser!.email.toString()),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.black,
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  if (user == null) {
                    print('User is currently signed out!');
                    Navigator.of(context).pushReplacementNamed(
                      '/sign-in',
                    );
                  } else {
                    print('User is signed in!');
                  }
                });
              },
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: FutureBuilder(
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If error occured
              if (snapshot.hasError) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: <Color>[
                        Color.fromARGB(255, 135, 35, 135), //255, 65, 89, 224
                        Color.fromARGB(255, 140, 30, 131), //255, 83, 92, 215
                        Color.fromARGB(255, 155, 33, 104), //255, 86, 88, 177
                        Color.fromARGB(255, 59, 74, 205), //255, 243, 144, 96
                        Color.fromARGB(255, 153, 94, 255), //255, 255, 181, 107
                      ],
                      tileMode: TileMode.mirror,
                    ),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: SafeArea(
                    child: Column(
                      children: [
                        AnimSearchBar(
                          //Hakupalkki näyttää paikkakuntalistan, kun alkaa kirjoittamaan?
                          rtl: true,
                          width: 400,
                          color: Colors.amber, //255, 255, 181, 107
                          textController: textController,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 26,
                          ),
                          onSuffixTap: () async {
                            textController.text == ""
                                ? log("No city entered")
                                : setState(() {
                                    _myData =
                                        getData(false, textController.text);
                                  });

                            FocusScope.of(context).unfocus();
                            textController.clear();
                          },
                          style: f14RblackLetterSpacing2,
                          onSubmitted: (String text) {},
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'City not found', //Kellonajat saa: now.hour.toString() + ":" + now.minute.toString()
                                style: f24Rwhitebold,
                              ),
                              Text('testi: ' + snapshot.data.toString())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                /*return Center(
                child: Text(
                  '${snapshot.error.toString()} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              ); */

                // if data has no errors
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                final data = snapshot.data as WeatherModel;

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: <Color>[
                        Color.fromARGB(255, 135, 35, 135), //255, 65, 89, 224
                        Color.fromARGB(255, 140, 30, 131), //255, 83, 92, 215
                        Color.fromARGB(255, 155, 33, 104), //255, 86, 88, 177
                        Color.fromARGB(255, 59, 74, 205), //255, 243, 144, 96
                        Color.fromARGB(255, 153, 94, 255), //255, 255, 181, 107
                      ],
                      tileMode: TileMode.mirror,
                    ),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: SafeArea(
                    child: Column(
                      children: [
                        AnimSearchBar(
                          //Hakupalkki näyttää paikkakuntalistan, kun alkaa kirjoittamaan?
                          rtl: true,
                          width: 400,
                          color: Colors.amber, //255, 255, 181, 107
                          textController: textController,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 26,
                          ),
                          onSuffixTap: () async {
                            textController.text == ""
                                ? log("No city entered")
                                : setState(() {
                                    isFavourite = !isFavourite;
                                    _myData =
                                        getData(false, textController.text);
                                  });

                            FocusScope.of(context).unfocus();
                            textController.clear();
                          },
                          style: f14RblackLetterSpacing2,
                          onSubmitted: (String text) {},
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (now.day.toString() +
                                    ". " +
                                    now.month.toString() +
                                    ". " +
                                    now.year
                                        .toString()), //Kellonajat saa: now.hour.toString() + ":" + now.minute.toString()
                                style: f16PW,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data.city + ", ",
                                    style: f24Rwhitebold,
                                  ),
                                  Text(
                                    data.country,
                                    style: f24Rwhitebold,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isFavourite = !isFavourite;
                                        });
                                        if (isFavourite) {
                                          listManager.add(
                                            WeatherModel(
                                                temp: data.temp,
                                                city: data.city,
                                                country: data.country,
                                                desc: data.desc,
                                                icon: data.icon,
                                                date: DateTime.now()),
                                            //  userid: FirebaseAuth.instance.currentUser!.uid.toString()
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text('Saved')));
                                        }
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: isFavourite
                                            ? Color.fromARGB(255, 210, 10,
                                                10) //255, 243, 144, 96
                                            : Color.fromARGB(
                                                255, 104, 104, 104),
                                      )) //255, 114, 113, 113
                                ],
                              ),
                              height25,
                              Text(
                                data.desc,
                                style: f16PW,
                              ),
                              height25,
                              Text(
                                "${data.temp} °C",
                                style: f42Rwhitebold,
                              ),
                              Image.network(
                                'https://openweathermap.org/img/wn/' +
                                    data.icon +
                                    '@2x.png',
                              ),
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InputView()),
                                      );
                                    },
                                    child: const Text("To My Weather Diary")),
                              ),
                              /*ElevatedButton(
                                onPressed: () async {
                                  await availableCameras().then((value) =>
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  CameraPage(cameras: value))));
                                },
                                child: Text("Take a picture"),
                              )*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text("${snapshot.connectionState} occured"),
              );
            }
            return Center(
              child: Text("Server timed out!"),
            );
          },
          future: _myData!,
        ),
      );
    });
  }
}
