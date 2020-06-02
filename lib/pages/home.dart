import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String city;
  String time;

  @override
  void initState() {
    super.initState();
    city = "Local";
    time = formatTime(DateTime.now());
  }

  String formatTime(DateTime time) {
    return DateFormat.jm().format(time).toString();
  }

  Future<DateTime> fetchTime(String timezone) async {
    String baseUrl = 'http://worldtimeapi.org/api/timezone/$timezone';
    var response = await get(baseUrl);
    var data = jsonDecode(response.body);
    DateTime timeUTC = DateTime.parse(data['datetime']);
    int utcOffsetHour = int.parse(data['utc_offset'].substring(1, 3));
    int utcOffsetMinute = int.parse(data['utc_offset'].substring(4, 6));
    timeUTC =
        timeUTC.add(Duration(hours: utcOffsetHour, minutes: utcOffsetMinute));
    return timeUTC;
  }

  void updateTime(String timezone) async {
    String timeStr = formatTime(await fetchTime(timezone));
    setState(() {
      city = timezone;
      time = timeStr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: SafeArea(
            child: Column(children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.location_on),
                FlatButton(
                  child: Icon(Icons.edit),
                  onPressed: () async {
                    var timezone =
                        await Navigator.pushNamed(context, '/location');
                    if (timezone != null) {
                      setState(() {
                        updateTime(timezone);
                      });
                    }
                  },
                )
              ]),
          SizedBox(
            height: 20,
          ),
          Text(
            '$city',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '$time',
            style: TextStyle(fontSize: 40),
          )
        ])),
      ),
    );
  }
}
