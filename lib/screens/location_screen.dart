import 'package:flutter/material.dart';
import 'package:weather_app/screens/error_message.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/screens/drawer_widget.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String city = "";

  void _getNewWeather(context) {
    Weather weather = Weather();
    weather.city = city;
    setState(() {
      weather.getWeatherFromCity().then((value){
        if (value['error'] != null){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ErrorMessage(error: value['error']['message']))
          );
        }
        else{
          if (!cityNames.contains(weather.city.toString().toLowerCase())){
            setState(() {
              cityNames.add(weather.city.toString().toLowerCase());
              cities.add(MyListTile(cityName: weather.city));
            });
          }
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen(response: value))
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text("Choose Location", style: kHeadingTextStyle,),
        centerTitle: true,
      ),
      backgroundColor: bodyBGColor,
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    onChanged: (value){
                      city = value;
                    },
                    style: kTextStyle,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter city name',
                      hintStyle: kTextStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12))
                    ),
                    onPressed: () {
                      setState(() {
                        _getNewWeather(context);
                      });
                    },
                    child: const Text("Get weather", style: kTextStyle,),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
