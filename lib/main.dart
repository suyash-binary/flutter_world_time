import 'package:flutter/material.dart';
import 'package:world_timer/pages/choose_location.dart';
import 'package:world_timer/pages/home.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/location': (context) => ChooseLocationPage(),
      },
    ));
