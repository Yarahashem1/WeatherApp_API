import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/main.dart';
import '../days.dart/screen.dart';
import '../models/wether.dart';

Widget createAppBar() {
  return Container(
      padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
      margin:
          const EdgeInsets.only(top: 35, left: 15.0, bottom: 15.0, right: 15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(60)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]),
      child: Text('Gaza'));
}

Widget weatherBox(Weather _weather,String location) {
  return Stack(alignment: AlignmentDirectional.topCenter, children: [
    Stack(
        //alignment: AlignmentDirectional.topCenter,
        children: [
          
          Container(
            // color: Color.fromARGB(255, 228, 10, 248),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.indigoAccent,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 60,
              top: 25,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${_weather.description}",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${_weather.temp!.toInt()}°",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 70,
                      color: Colors.white),
                )
              ],
            ),
          ),
          ClipPath(
              clipper: Clipper(),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 5),
                child: Container(
                    height: 200,
                    width: 195,
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent[400],
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              )),
          Padding(
              padding: EdgeInsetsDirectional.only(
                start: 28,
                top: 115,
              ),
              child: getWeatherIcon(_weather.icon))
        ]),
    Padding(
      padding: const EdgeInsetsDirectional.only(
          // start:7

          ),
      child: Container(
        // color: Color.fromARGB(255, 228, 10, 248),
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child:  Text(
                    location.substring(0,1).toUpperCase()+location.substring(1),
                    style: TextStyle(fontSize: 18,),
                    textAlign: TextAlign.center,
                    ),
        ),
      ),
    ),
  ]);
}

Image getWeatherIcon(String? _icon) {
  String path = 'assets/icons/';
  String imageExtension = ".png";
  return Image.asset(
    path + _icon! + imageExtension,
    width: 150,
    height: 150,
  );
}

Image getWeatherIconSmall(String? _icon) {
  String path = 'assets/icons/';
  String imageExtension = ".png";
  return Image.asset(
    path + _icon! + imageExtension,
    width: 60,
    height: 60,
  );
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height - 20);

    path.quadraticBezierTo((size.width / 6) * 1, (size.height / 2) + 15,
        (size.width / 3) * 1, size.height - 30);
    path.quadraticBezierTo((size.width / 2) * 1, (size.height + 0),
        (size.width / 3) * 2, (size.height / 4) * 3);
    path.quadraticBezierTo((size.width / 6) * 5, (size.height / 2) - 20,
        size.width, size.height - 60);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 3, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}

Widget bootomm(Weather _weather,String location) {

  return Stack(
      //alignment: AlignmentDirectional.topCenter,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: 80,
          ),
          child: Stack(
           // alignment: AlignmentDirectional.centerEnd,
            children:[

             Stack(alignment: AlignmentDirectional.bottomCenter, children: [
              Container(
                width: double.infinity,
                color: Colors.grey[100],
                height: 215,
              ),
              Container(
                  height: 150,
                  //width: 40,
                  alignment: AlignmentDirectional.topCenter,
                  child:weathereLayout(location: location,)),
            ]),
               Padding(
                 padding: const EdgeInsetsDirectional.only(start: 270,top:45),
                 child: Text('Next 7 days >',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
               )
       ] ),

        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 23,
            top: 15,
          ),
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 15),
            margin:
                const EdgeInsets.only(left: 15, top: 5, bottom: 15, right: 15),
            height: 100,
            width: 280,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ]),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                     Container(

                        child:Icon(Icons.cloud,size: 17,color: Colors.indigoAccent,)
                        ),
                  SizedBox(height: 7,),
                    Container(
                        child: Text(
                      "${_weather.wind} km/h",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.black),
                    )),
                      Container(

                        child: Text(
                      "Wind",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Colors.grey),
                    )),
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                     Container(

                        child:Icon(Icons.water_drop,size: 17,color: Colors.indigoAccent,)
                        ),
                  SizedBox(height: 7,),
                      Container(
                        child: Text(
                      "${_weather.humidity!.toInt()}%",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.black),
                    )),
                      Container(

                        child: Text(
                      "Humidity",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Colors.grey),
                    )),
                ],
                )),
                Expanded(
                    child: Column(
                  children: [
                     Container(

                        child:Icon(Icons.remove_red_eye_sharp,size: 17,color: Colors.indigoAccent,)
                        ),
                  SizedBox(height: 7,),
                      Container(
                        child: Text(
                      "${(_weather.visibality!/1000)} km",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.black),
                    )),
                      Container(

                        child: Text(
                      "Pressure",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Colors.grey),
                    )),
               ],
                ))
              ],
            ),
          ),
        ),
      ]);

  
}

Widget currentWeatherViews(String location) {
  Weather _weather;

  return FutureBuilder<Weather>(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _weather = snapshot.data!;
        if (_weather == null) {
          return Text("Error getting weather");
        } else {
          return Column(children: [
            if (location!=null)
            weatherBox(_weather,location),
            bootomm(
              _weather,location
            ),

            // weatherDetailsBox(_weather),
          ]);
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    future: getCurrentWeather(location),
  );
}

Future<Weather> getCurrentWeather(String location) async {
  Weather? weather;

  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=b9f03ff8fcde2139195df21adcdf3b28&units=metric");

  final response = await http.get(url);

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  }

  return weather!;
}


Widget buildItem(article,String location) =>  Container(
      margin: EdgeInsets.symmetric(vertical: 0.0),
      height: 150.0,
      child:  Container(
            width: 140,
            height: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     Text(
                    location.substring(0,1).toUpperCase()+location.substring(1),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                     SizedBox(height: 5,),
                    Text(
                      '${article['weather'][0]['description']}',),
                     SizedBox(height: 5,),
                    Text(
                        '${(article['main']['temp']-273.15).toInt()}°',
                     
                    ),
                    SizedBox(height: 5,),
                    Container(
                      child: getWeatherIconSmall(article['weather'][0]['icon']),
                      //padding: EdgeInsetsDirectional.only(bottom: 60),
                      ),
                   
                  ],
                ),
              ),
            ),
          )
       );
 

Widget weathereBuilder(list,String? location) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
         scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.transparent,
          width: 5,
        ),
        
        itemBuilder: (context, index) => buildItem(list[index],location!),
       
        itemCount: 7,
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );

