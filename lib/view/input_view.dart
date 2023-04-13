import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
//import 'weather_page.dart';
//import 'package:weather_app/globals.dart';
import 'package:weather_app/logic/models/weather_list_manager.dart';
import 'package:weather_app/view/weather_page.dart';
import '../camera_page.dart';
import '../logic/models/weather_model.dart';
import 'package:provider/provider.dart';

// Create a Form widget.
class InputView extends StatefulWidget {
  InputView({
    Key? key,
    int? index,
  }) : super(key: key);
  final storage = FirebaseStorage.instance;

// Create the file metadata
  final metadata = SettableMetadata(contentType: "image/jpg");

  @override
  State<InputView> createState() {
    return InputViewState();
  }
}

class InputViewState extends State<InputView> {
  final _formKey = GlobalKey<FormState>();
  final storageRef = FirebaseStorage.instance.ref();
  int index = -1;
  String? imageName = "";
  String imageUrl = "";
/*
  Future<void> imageURLdownload() async {
    imageUrl = 
    //await storageRef.child(imageName!).getDownloadURL();
    //imageUrl =
    //  await storageRef.child('CAP7682421739371229962.jpg').getDownloadURL();
  }*/

  @override
  void initState() {
    super.initState();
    //imageURLdownload();
  }

  @override
  Widget build(BuildContext context) {
    List<WeatherModel> itemList = [];

    return Consumer<WeatherListManager>(builder: (context, listManager, child) {
      itemList.forEach((item) {
        listManager.add(item);
      });
      imageName = listManager.getItem(index)?.pictureURL;
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeatherPage()),
                );
              },
            ),
          ),
          body: ListView.builder(
            itemCount: listManager.items.length,
            itemBuilder: (
              BuildContext ctxt,
              int index,
            ) {
              return _buildCard(
                listManager,
                listManager.items[index].temp,
                listManager.items[index].city,
                listManager.items[index].country,
                listManager.items[index].desc,
                listManager.items[index].icon,
                listManager.items[index].date,
                listManager.items[index].pictureURL,
                context,
                index,
              );
            },
          ));
    });
  }

  Center _buildCard(
    WeatherListManager listManager,
    String? temp,
    String? city,
    String? country,
    String? desc,
    String? icon,
    DateTime date,
    String? pictureURL,
    BuildContext context,
    int index,
  ) {
    temp ??= "";
    city ??= "";
    country ??= "";
    desc ??= "";
    icon ??= "";
    date;
    Color _iconColor = Colors.white;
    print("indeksi:   $index");

    return Center(
        child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "${date.hour}:${date.minute < 10 ? '0' : ''}${date.minute} -"),
                Text(" ${date.day}.${date.month}.${date.year}"),
              ],
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(city + ","),
                      Text(" " + country),
                    ],
                  ),
                  //Text(temp),
                  //Text(city),
                  //Text(country),
                  //Text(desc),
                  //Text(icon),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Temperature: " + temp + " °C")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Description: " + desc)],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(children: [
              Center(child: Image.network(height: 100, width: 100, pictureURL!))
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () async {
                    await availableCameras().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CameraPage(cameras: value, index: index))));
                  },
                  child: Text("Take a picture"),
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title:
                          const Text('Are you sure you want to delete card?'),
                      //content: const Text('AlertDialog description'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          //onPressed: () {}=> Navigator.pop(context, 'Delete'),
                          onPressed: () {
                            listManager.deleteItem(listManager.items[index]);
                            Navigator.pop(context, 'Delete');
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
