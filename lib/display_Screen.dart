import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/weakly_weather.dart';




class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
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

                Container(
                  height: 300,
                  width: 300,
                  child: Center(child: Image.asset('assests/nighticon.png',
                  fit: BoxFit.cover,)),

                ),
                SizedBox(height: 10,),

                Center(child: Text("Real-Time Weather Map",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
                SizedBox(height: 5,),
                Text("Watch the progress of the precipitation to stay informed",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 10,color: Colors.black),),


                        SizedBox(height: 80,),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: InkWell(
                        onTap:() {
                          Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => WeatherScreen()),
                          );
                        },
                        child: Icon(Icons.arrow_forward_ios_outlined)
                  ),
                  ),
                )
              ],
            )
          ],
        ),
      
      
      
      ),
    );
  }
}
