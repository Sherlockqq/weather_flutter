import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_flutter/ui/weather_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final searchController = TextEditingController();

  Set<String> recentlyCities = {};

  void searchIsClicked() {
    setState(() {
      recentlyCities.add(searchController.text);
    });
  }

  void deleteItem(String value) {
    setState(() {
      recentlyCities.remove(value);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 32, 8, 0),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Input city ...'),
          ),
        ),
        TextButton(
          onPressed: () {
            //var weatherModel = await _getData();
            searchIsClicked();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WeatherScreen(city: searchController.text);
            }));
          },
          child: const Text("Search"),
        ),
        const Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Text("Recently Searched")),
        Expanded(
            child: ListView.builder(
                itemCount: recentlyCities.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                        height: 50,
                        color: Colors.deepOrange,
                        child: InkWell(
                          child: Center(
                            child: Text(recentlyCities.elementAt(index)),
                          ),
                          onLongPress: () {
                            deleteItem(recentlyCities.elementAt(index));
                          },
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return WeatherScreen(
                                  city: recentlyCities.elementAt(index));
                            }));
                          },
                        )),
                  );
                }))
      ]),
    ));
  }
}
