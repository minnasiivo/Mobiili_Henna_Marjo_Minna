import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:weather_app/data/firebase_helper.dart';
import 'package:weather_app/view/input_view.dart';

class PreviewPage extends StatelessWidget {
  PreviewPage({Key? key, required this.picture}) : super(key: key);
  final storage = FirebaseStorage.instance;
  final XFile picture;

// Create the file metadata
  final metadata = SettableMetadata(contentType: "image/jpg");

// Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
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
                final uploadTask = storageRef
                    .child(
                        "${FirebaseAuth.instance.currentUser!.uid}/${picture.name}")
                    .putFile(file, metadata);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputView()),
                );
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Saved')));

                final imageURL = await storageRef
                    .child(
                        "${FirebaseAuth.instance.currentUser!.uid}/${picture.name}")
                    .getDownloadURL();
              },
              child: const Text("Save Image")),
        ]),
      ),
    );
  }
}
