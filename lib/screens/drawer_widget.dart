import 'package:flutter/material.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/utilities/constants.dart';

import '../services/weather.dart';
import 'error_message.dart';

List<Widget> cities = [
  DrawerHeader(
    decoration: BoxDecoration(
        color: Colors.indigo,
        border: Border(bottom: BorderSide(color: Colors.blue, width: 10))
    ),
    child: Text("Past Locations", style: kHeadingTextStyle.copyWith(fontSize: 30),),
  ),
];
List<String> cityNames = [];

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  void updateCities(Widget newCity) {
    setState(() {
      cities.add(newCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appBarColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cities,
      ),
    );
  }
}

class MyListTile extends StatefulWidget {
  final cityName;
  MyListTile({this.cityName});

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  void _getNewWeather(context) {
    Weather weather = Weather();
    weather.city = widget.cityName;
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
    return ListTile(
      onTap: (){
        _getNewWeather(context);
      },
      title: Text(widget.cityName, style: kTextStyle,),
      style: ListTileStyle.list,
    );
  }
}

