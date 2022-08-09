import 'dart:convert';
import 'package:weather_app/utilities/environmentReader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Weather{
  Weather({this.latitude, this.longitude});
  dynamic latitude = 0;
  dynamic longitude = 0;
  dynamic city = "";

  Future<dynamic> getWeather() async{
    dynamic env = await parseStringToMap(assetsFileName: '.env');
    dynamic url = Uri.parse("http://api.weatherapi.com/v1/forecast.json?${env['KEY']}&q=$latitude,$longitude");
    Response response = await get(url);
    return jsonDecode(response.body);
  }

  Future<dynamic> getWeatherFromCity() async{
    dynamic env = await parseStringToMap(assetsFileName: '.env');
    dynamic url = Uri.parse("http://api.weatherapi.com/v1/forecast.json?${env['KEY']}&q=$city");
    Response response = await get(url);
    return jsonDecode(response.body);
  }
}