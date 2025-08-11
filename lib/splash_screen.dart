import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:weather_app/display_Screen.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/weakly_weather.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 5), () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => DisplayScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xffFDFAF6),
      body:Stack(
        children: [
        // 1. Background Image
        Image.asset(
        'assests/images/backimage.jpg',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                height: 300,
                width: 300,
                child: Center(
                  child: Image.asset('assests/sun.png',
                  fit: BoxFit.cover,),
                ),


              ),
            ),
          ),

          SizedBox(height: 10,),


          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "W",
                  style: TextStyle(
                    fontSize: 100,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                TextSpan(
                  text: "eather",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              TextSpan(
                text: "App",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              )

              ],
            ),

          ),


        ],

      ),
   ] )
    );
  }
}
