import 'dart:async';
import 'dart:ui'; // Needed for the BackdropFilter (blur effect)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/home_screen.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/splash_screen.dart';
import 'package:weather_app/weakly_weather.dart';
import 'package:weather_app/weather_get_model.dart';
import 'fetch_weather_data.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<WeatherGetModel> weatherFuture;
  final TextEditingController _textController = TextEditingController();
  late Future<Position> currentLocation;

  late Timer _timer;
  DateTime now = DateTime.now();

  String location="Loading loation";


  @override
  void initState() {
    super.initState();
    weatherFuture = WeatherData().fetchWeatherData();
    currentLocation = WeatherData().getCurrentLocation();

    loadLocation();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        now = DateTime.now();
      });
    });
  }


  @override
  void dispose() {
    _textController.dispose();
    _timer.cancel();
    super.dispose();
  }


  void loadLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String cityCountryName = await WeatherData().getCityCountryName(position);

      setState(() {
        location = cityCountryName;
      });

      Text(location);
    } catch (e) {
      Text('Error loading location: $e');
      setState(() {
        location = "Location not available";
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY).format(
        now);


    return
      Expanded(
        child: Scaffold(

            body: FutureBuilder<WeatherGetModel>(
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
                 DateFormat.H().format(now);

                  return Stack(
                    children: [
                      // 1. Background Image
                      Image.asset(
                        'assests/images/night.jpg',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),

                      // 2. Main Content on top of the background
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [

                              // Spacer to push content down from the top
                              const SizedBox(height:50),

                              // 3. Time and Date
                              Text(
                                DateFormat.jm().format(now),
                                style: TextStyle(fontSize: 70,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white70),
                              ),

                              // Spacer to push the cards down
                              const Spacer(),

                              // 4. Forecast Card (Glass Effect)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        // Individual forecast items
                                        _buildForecastColumn(
                                            '${  DateFormat('h a').format(now)}', Icons.cloud_outlined,
                                            '36° C'),
                                        _buildForecastColumn(
                                            '${  DateFormat('h a').format(now.add(Duration(hours: 1)))}', Icons.cloud_outlined,
                                            '36° C'),
                                        _buildForecastColumn(
                                            '${  DateFormat('h a').format(now.add(Duration(hours: 2)))}', Icons.cloud_outlined,
                                            '36° C'),
                                        _buildForecastColumn(
                                            '${  DateFormat('h a').format(now.add(Duration(hours: 3)))}', Icons.wb_sunny_outlined,
                                            '33° C'),
                                        _buildForecastColumn(
                                            '${  DateFormat('h a').format(now.add(Duration(hours: 4)))}', Icons.cloud,
                                            '36° C'),
                                        _buildForecastColumn(
                                            '${  DateFormat('h a').format(now.add(Duration(hours: 5)))}', Icons.cloudy_snowing,
                                            '36° C'),
                                        _buildForecastColumn(
                                            '${  DateFormat('h a').format(now.add(Duration(hours: 6)))}', Icons.cloudy_snowing,
                                            '36° C'),
                                        _buildForecastColumn(
                                            '${  DateFormat('h a').format(now.add(Duration(hours: 7)))}', Icons.cloudy_snowing,
                                            '36° C'),

                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // 5. Current Weather Details Card (Glass Effect)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Location and options icon
                                        Row(
                                          children: [
                                            //this is showing Country & city name using geolocator and geoCoding Package
                                            Text('$location', style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                            Spacer(),
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context)  => WeaklyWeather(),) );

                                              },
                                              child: Icon(Icons.more_horiz,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        // Main weather info row
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Builder(builder: (context){
                                                num tempC = weather.main!.temp!;
                                                num displayTemp;

                                                if (tempC > 0) {
                                                  displayTemp = tempC;
                                                } else {
                                                  displayTemp = (tempC * 9 / 5) + 32;
                                                }

                                                String unit = tempC > 0 ? "°C" : "°F";
                                                return
                                                  Text('${displayTemp.toInt() }$unit',
                                                      style: TextStyle(fontSize:60,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold));


                                              }),
                                            ),




                                            Expanded(child: MosaamUpdate()), //shows images related

                                          ],
                                        ),
                                        // Weather text details
                                        //'Partly cloudy'
                                        Text(weather.weather?.isNotEmpty == true
                                            ? weather.weather![0].main ?? 'N/A'
                                            : 'No weather data', style: TextStyle(
                                            color: Colors.white70)),
                                        Text('Wind ${(weather.wind?.speed ??
                                            0 * 3.6).toStringAsFixed(1)} Km/h',
                                            style: TextStyle(
                                                color: Colors.white70)),
                                        Text('Humidity ${weather.main!.humidity!
                                            .toString()} %', style: TextStyle(
                                            color: Colors.white70)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Spacer to push content up from the bottom
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
            )


        ),
      );
  }




  Widget _buildForecastColumn(String hour, IconData icon, var temp) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
            child: Text(hour as String, style: const TextStyle(color: Colors.white70))),
        const SizedBox(height: 8),
        Icon(icon, color: Colors.yellow, size: 30),
        const SizedBox(height: 8),
        Text(temp, style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }


  Widget MosaamUpdate() {
    return FutureBuilder<WeatherGetModel>(
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
        final String mosam = weather.weather != null &&
            weather.weather!.isNotEmpty
            ? weather.weather![0].main ?? 'N/A'
            : 'No weather data';

        var currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        var sunset = weather.sys!.sunrise!;
        var sunrise = weather.sys!.sunrise!;

        bool isNight = currentTime > sunset && currentTime < sunrise;

        return Column(
          children: [

             if(isNight)
               Image.asset('assests/nighticon.png', width: 132, height: 170),
            if (mosam == "Clouds")
              Image.asset('assests/cludy.png', width: 132, height: 170),
            if (mosam == "Clear")
              Image.asset('assests/sun.png', width: 154, height: 200),
            if (mosam != "Clouds" && mosam != "Clear")
              Text("Weather: $mosam"),







          ],
        );
      },

    );
  }





}