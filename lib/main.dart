import 'package:flutter/material.dart';
import 'constant/component.dart';
import 'constant/dio.dart';

TextEditingController location = TextEditingController();
void main() {
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 229, 242, 255),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 229, 242, 255),
          elevation: 0,
          title: TextFormField(
            controller: location,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,),
                hintText: '  Enter Location...'),
            onChanged: (val) {
              setState(() {});
            
            },
          ),
        ),
        body: 
        ListView(children: <Widget>[
          SizedBox(height: 10,),
            if (location.text.isEmpty) 
              currentWeatherViews('gaza'),
          currentWeatherViews(location.text),
        ]));
  }
}
