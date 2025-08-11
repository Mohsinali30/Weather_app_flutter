



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/app_url_api.dart';
import 'package:weather_app/weather_get_model.dart';
import 'package:geolocator/geolocator.dart';
class WeatherData {



  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
  }

  Future<WeatherGetModel> fetchWeatherData() async{
    Position position = await getCurrentLocation();
    double lat = position.latitude;
    double lon = position.longitude;

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${APPUrl().API_Key}&units=metric'));

    if (response.statusCode==200){
       var data =jsonDecode(response.body);
       return WeatherGetModel.fromJson(data);
     }
     else{
       throw Exception("Error");
     }

  }



  Future<String> getCityCountryName(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // Placemark has details like locality, country, etc.
    Placemark place = placemarks[0];
    return '${place.locality}, ${place.country}'; //  Karachi, Pakistan
  }





}
