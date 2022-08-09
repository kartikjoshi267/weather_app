import 'package:flutter/material.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/screens/drawer_widget.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Location location = Location();
  Widget body = Scaffold(
    body: Center(
      child: Image.asset(
        'images/weather.gif',
        width: double.infinity,
        alignment: Alignment.center,
      ),
    ),
  );

  void _changeScreen(response){
    body = MainScreen(response: response,);
  }

  Future<dynamic> _getLocation(context) async{
    await location.getCurrentLocation(context);

    Weather weather = Weather(longitude: location.longitude, latitude: location.latitude);
    dynamic json = await weather.getWeather();
    weather.city = json['location']['name'];
    if (!cityNames.contains(weather.city.toString().toLowerCase())){
      setState(() {
        cityNames.add(weather.city.toString().toLowerCase());
        cities.add(MyListTile(cityName: weather.city));
      });
    }
    return json;
  }

  @override
  void initState() {
    super.initState();
    _getLocation(context).then((value){
      setState(() {
        _changeScreen(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return body;
  }
}
