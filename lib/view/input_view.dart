import 'package:flutter/material.dart';
//import 'weather_page.dart';
//import 'package:weather_app/globals.dart';
import 'package:weather_app/logic/models/weather_list_manager.dart';
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
    void initState(){
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
                  context,
                  index);
            },
          ));
    });
  }

  Center _buildCard(WeatherListManager listManager, String? temp, String? city, String? country, String? desc,
      String? icon, BuildContext context, int index) {
    temp ??="";
    city ??= "";
    country ??="";
    desc ??= "";
    icon ??= "";
    Color _iconColor = Colors.white;
    return Center(
        child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Text(temp),
                  Text(city),
                  Text(country),
                  Text(desc),
                  Text(icon),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Muokkaa'),
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InputTaskView(index: index)),
                               
                    ); listManager.editItem(index, listManager.items[index]); */

                  },
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Poista'),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Haluatko varmasti poistaa tehtävän?'),
                      //content: const Text('AlertDialog description'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Peruuta'),
                        ),
                        TextButton(
                          //onPressed: () {}=> Navigator.pop(context, 'Delete'),
                          onPressed: () {
                           listManager.deleteItem(listManager.items[index]);
                            Navigator.pop(context, 'Delete');
                          },
                          child: const Text('Poista'),
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
