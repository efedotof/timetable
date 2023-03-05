import 'package:flutter/material.dart';

import 'package:weekly_date_picker/weekly_date_picker.dart';
import 'package:raspisanie2/screens/raspscreens.dart';
import 'package:raspisanie2/screens/splashscreen.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(primaryColor: Color.fromARGB(244, 243, 249, 249)),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/todo': (context) => MyApp(),
      },
      debugShowCheckedModeBanner: false,
    ));
