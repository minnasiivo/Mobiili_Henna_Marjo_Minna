import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'weather_page.dart';
//import 'package:weather_app/globals.dart';
import 'package:weather_app/logic/models/weather_list_manager.dart';
import 'package:weather_app/view/weather_page.dart';
import '../camera_page.dart';
import '../logic/models/weather_model.dart';
import 'package:provider/provider.dart';

// Create a Form widget.
class InputView extends StatefulWidget {
  const InputView({super.key});

  @override
  State<InputView> createState() {
    return InputViewState();
  }
}

class InputViewState extends State<InputView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<WeatherModel> itemList = [];

    return Consumer<WeatherListManager>(builder: (context, listManager, child) {
      itemList.forEach((item) {
        listManager.add(item);
      });

      return Scaffold(
          appBar: AppBar(title: Text('testi')),
          body: ListView.builder(
            itemCount: listManager.items.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return _buildCard(
                  listManager,
                  listManager.items[index].temp,
                  listManager.items[index].city,
                  listManager.items[index].country,
                  listManager.items[index].desc,
                  listManager.items[index].icon,
                  listManager.items[index].date,
                  context,
                  index);
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
      BuildContext context,
      int index) {
    temp ??= "";
    city ??= "";
    country ??= "";
    desc ??= "";
    icon ??= "";
<<<<<<< HEAD
    date = DateTime.now();

=======
    date;
>>>>>>> be8165ed6b6457edfa3fb1b256a27496c828fb22
    Color _iconColor = Colors.white;
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
                Text("${date.hour}:${date.minute<10?'0':''}${date.minute} -"),
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
