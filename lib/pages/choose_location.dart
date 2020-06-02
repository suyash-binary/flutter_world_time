import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ChooseLocationPage extends StatefulWidget {
  @override
  _ChooseLocationPageState createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  List<String> locations;

  void getTime() async {
    try {
      var response = await get("http://worldtimeapi.org/api/timezone");
      var data = jsonDecode(response.body);
      var locationList = List<String>();
      data.forEach((e) {
        locationList.add(e);
      });
      setState(() {
        locations = locationList;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    locations = List<String>();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Location"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${locations[index]}'),
                onTap: (){
                  //print('${locations[index]}');
                  Navigator.pop(context, locations[index]);
                },
              );
            }),
      ),
    );
  }
}
