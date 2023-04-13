import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/firebase_helper.dart';
import 'package:weather_app/view/input_view.dart';

import 'logic/models/weather_list_manager.dart';
import 'logic/models/weather_model.dart';

class PreviewPage extends StatelessWidget {
  PreviewPage({Key? key, required this.picture, this.index = -1})
      : super(key: key);

  late final int index;
  final storage = FirebaseStorage.instance;
  final XFile picture;
  String temp = "";
  String city = "";
  String country = "";
  String desc = "";
  String icon = "";
  int id = -1;
  String? fbid;
  DateTime date = DateTime.now();
  String? userid;
  String? pictureURL;
// Create the file metadata
  final metadata = SettableMetadata(contentType: "image/jpg");

// Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherListManager>(builder: (context, listManager, child) {
      {
        WeatherModel? item =
            Provider.of<WeatherListManager>(context, listen: false)
                .getItem(index);
        if (item != null) {
          temp = item.temp;
          city = item.city;
          country = item.country;
          desc = item.desc;
          icon = item.icon;
          id = item.id;
          fbid = item.fbid;
          date = item.date;
          userid = item.userid;
          pictureURL = item.pictureURL;
        }
      }

      return Scaffold(
        appBar: AppBar(title: const Text('Preview Picture')),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
            const SizedBox(height: 24),
            Text(picture.name),
            ElevatedButton(
                onPressed: () async {
                  final file = File(picture.path);
                  final uploadTask = await storageRef
                      .child(
                          "${FirebaseAuth.instance.currentUser!.uid}/${picture.name}")
                      .putFile(file, metadata);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Saved')));

                  final imageURL = await storageRef
                      .child(
                          "${FirebaseAuth.instance.currentUser!.uid}/${picture.name}")
                      .getDownloadURL();

                  print("IMAGEN URL TOIVOTTAVASTI: " + imageURL);

                  /*uploadTask.storage
                      .ref(picture.path)
                      .getDownloadURL();*/

                  listManager.editItem(
                      index,
                      WeatherModel(
                        temp: temp,
                        city: city,
                        country: country,
                        desc: desc,
                        icon: icon,
                        id: id,
                        date: date,
                        userid: userid,
                        fbid: fbid,
                        pictureURL: imageURL,
                      ));

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InputView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 145, 85, 245),
                  // Background color
                ),
                child: const Text("Save Image")),
          ]),
        ),
      );
    });
  }
}
