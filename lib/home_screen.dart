import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/main.dart';
import 'fetch_weather_data.dart';
import 'weather_get_model.dart';


class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  late Future<WeatherGetModel> weatherFuture;
  final TextEditingController _textController = TextEditingController();

  late Timer _timer;
  DateTime now= DateTime.now();


  @override
  void initState() {
    super.initState();
    weatherFuture = WeatherData().fetchWeatherData();

    _timer = Timer.periodic(Duration(seconds: 1), (Timer t){
      setState(() {
        now =DateTime.now();

      });
    });
  }



  @override
  void dispose() {
    _textController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY).format(now);


    return Scaffold(
      backgroundColor: const Color(0xFFFEA14E),
      body: SafeArea(
        child: FutureBuilder<WeatherGetModel>(
          future: weatherFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            final weather = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
                  child: TextFormField(
                    controller: _textController,
                    onChanged: (value) {
                      // Add search logic here if needed
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                      hintText: 'Search',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide:  BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),


                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //show date & time

                       Text(
                           DateFormat.jm().format(now),
                        //"Time ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                       Text(
                         formattedDate,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),


                    ],
                  ),
                ),

                Expanded(
                  child: Opacity(
                    opacity: 0.8,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEB054),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          Row(

                            children: [

                              Image.asset(
                                'assests/cloudy.png', // fixed asset folder name

                                width: 60,
                                height: 60,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  '${weather.main!.temp!.toString()}°C',
                                  style: const TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              const SizedBox(width: 10),


                              Expanded(
                                child: Text(
                                  weather.main!.feelsLike!.toStringAsFixed(1),
                                  style: const TextStyle(fontSize: 24, color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 100,
                  color: const Color(0xFFFEA14E),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return HourlyForecast(temp: '${weather.main!.temp!.toStringAsFixed(1)} + $index°');
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HourlyForecast extends StatelessWidget {
  final String temp;
  const HourlyForecast({required this.temp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Colors.white70,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(temp, style: const TextStyle(color: Colors.black)),
            const Text('14:00', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
