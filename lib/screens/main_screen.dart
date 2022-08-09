import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/utilities/constants.dart';

import 'drawer_widget.dart';

class MainScreen extends StatefulWidget {
  MainScreen({this.response});
  final dynamic response;

  @override
  State<MainScreen> createState() => _MainScreenState(response: response);
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState({this.response});
  final dynamic response;

  Color _checkTime(){
    if (response['current']['is_day'] != 0){
      return Color(0xFF1363DF);
    }

    return Color(0xFF003EB0);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      bodyBGColor = _checkTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: bodyBGColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LocationScreen()),
          );
        },
        label: Text("Choose Location", style: kTextStyle,),
        icon: Icon(Icons.location_on_outlined, color: Colors.white,),
      ),
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          response['location']['name'] + ', ' + response['location']['country'],
          style: kHeadingTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFF000644),
                    borderRadius: BorderRadius.all(Radius.circular(152))
                  ),
                  child: Image.network(
                    "https:${response['current']['condition']['icon'] ?? 'https://cdn.weatherapi.com/weather/64x64/night/113.png'}",
                    scale: 0.4,
                  ),
                ),
              ),
              Container(
                child: Text("${response['current']['temp_c']} °C", style: kHeadingTextStyle.copyWith(fontSize: 40), textAlign: TextAlign.center,),
              ),
              Container(
                child: Text("${response['current']['condition']['text']}", style: kHeadingTextStyle.copyWith(fontSize: 25), textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text("${response['forecast']['forecastday'][0]['day']['maxtemp_c']} °C", style: kTextStyle, textAlign: TextAlign.center,),
                    ),
                    Text(' / ', style: kTextStyle.copyWith(fontSize: 30),),
                    Container(
                      child: Text("${response['forecast']['forecastday'][0]['day']['mintemp_c']} °C", style: kTextStyle, textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
            ],
          ),
            Container(
              margin: EdgeInsets.all(6),
              color: Color(0xFF000644),
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("UV radiation level:", style: kTextStyle,),
                  Text("${response['current']['uv']}", style: kTextStyle,),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(6),
              color: Color(0xFF000644),
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Humidity:", style: kTextStyle,),
                  Text("${response['current']['humidity']}", style: kTextStyle,),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(6),
              color: Color(0xFF000644),
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Wind Speed:", style: kTextStyle,),
                  Text("${response['current']['wind_kph']}", style: kTextStyle,),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(6),
              color: Color(0xFF000644),
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Wind Direction:", style: kTextStyle,),
                  Text("${response['current']['wind_dir']}", style: kTextStyle,),
                ],
              ),
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
    // return Container(
    //   color: Colors.deepPurple,
    //   padding: EdgeInsets.all(20),
    //   child: Container(
    //     child: Center(
    //       child: SafeArea(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Expanded(
    //                 child: Text(
    //                     "City name here",
    //                     style: kHeadingTextStyle
    //                 ),
    //             ),
    //             Expanded(
    //                 child: Image.network('https://cdn.weatherapi.com/weather/64x64/night/113.png', scale: 0.0001,),
    //             ),
    //             Expanded(
    //                 child: Text("20°C", style: kTextStyle,)
    //             ),
    //             Expanded(
    //               child: Text("°", style: kTextStyle,),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
