import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
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
                // Listen for state changes, errors, and completion of the upload.
                uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
                  switch (taskSnapshot.state) {
                    case TaskState.running:
                      final progress = 100.0 *
                          (taskSnapshot.bytesTransferred /
                              taskSnapshot.totalBytes);
                      print("Upload is $progress% complete.");
                      break;
                    case TaskState.paused:
                      print("Upload is paused.");
                      break;
                    case TaskState.canceled:
                      print("Upload was canceled");
                      break;
                    case TaskState.error:
                      // Handle unsuccessful uploads
                      break;
                    case TaskState.success:
                      // Handle successful uploads on complete
                      // ...
                      break;
                  }
                });
              },
              child: const Text("Save Image")),
        ]),
      ),
    );
  }
}
