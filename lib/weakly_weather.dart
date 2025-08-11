import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class WeaklyWeather extends StatefulWidget {
  const WeaklyWeather({super.key});

  @override
  State<WeaklyWeather> createState() => _WeaklyWeatherState();
}

class _WeaklyWeatherState extends State<WeaklyWeather> {

  late Timer _timer;
  DateTime now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children:[
            Image.asset(
              'assests/images/night.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),


            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assests/night.png'),
                  fit: BoxFit.cover,
                ),
              ),



              child: ListView(
                children: [
                  _buildForecastWeekly('${DateFormat('EEE, d').format(now)}', Icons.wb_sunny_outlined, '36° C'),
                  _buildForecastWeekly('${DateFormat('EEE, d').format(now.add(Duration(days: 1)))}', Icons.cloud_outlined, '36° C'),
                  _buildForecastWeekly('${DateFormat('EEE, d').format(now.add(Duration(days: 2)))}', Icons.wb_sunny_outlined, '33° C'),
                  _buildForecastWeekly('${DateFormat('EEE, d').format(now.add(Duration(days: 3)))}', Icons.cloudy_snowing, '36° C'),
                  _buildForecastWeekly('${DateFormat('EEE, d').format(now.add(Duration(days: 4)))}', Icons.cloudy_snowing, '36° C'),
                  _buildForecastWeekly('${DateFormat('EEE, d').format(now.add(Duration(days: 5)))}', Icons.cloudy_snowing, '36° C'),
                  _buildForecastWeekly('${DateFormat('EEE, d').format(now.add(Duration(days: 6)))}', Icons.sunny_snowing, '36° C'),
                  _buildForecastWeekly('${DateFormat('EEE, d').format(now.add(Duration(days: 7)))}', Icons.sunny_snowing, '36° C'),
                ],
              ),
                        ),
            ),
      ]  ),
      ),
    );
  }

  Widget _buildForecastWeekly(String day, IconData icon, String temp) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 17),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          day.toString(),
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        subtitle: Text(
          temp,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(icon, color: Colors.yellow, size: 70),
        ),
      ),
    );
  }

}
