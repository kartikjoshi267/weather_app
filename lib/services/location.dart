import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/screens/error_message.dart';

class Location{
  dynamic latitude;
  dynamic longitude;

  Future<void> getCurrentLocation(context) async{
    LocationPermission locationPermission = await Geolocator.requestPermission();
    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, timeLimit: Duration(seconds: 6));
      latitude = position.latitude;
      longitude = position.longitude;
    }
    catch(e){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ErrorMessage(error: "Unable to fetch your location",)));
    }
  }
}