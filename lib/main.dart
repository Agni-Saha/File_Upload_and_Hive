import 'package:file_upload/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('audio_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Upload',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFFFFCC27,
          {
            50: Color.fromRGBO(255, 204, 39, .1),
            100: Color.fromRGBO(255, 204, 39, .2),
            200: Color.fromRGBO(255, 204, 39, .3),
            300: Color.fromRGBO(255, 204, 39, .4),
            400: Color.fromRGBO(255, 204, 39, .5),
            500: Color.fromRGBO(255, 204, 39, .6),
            600: Color.fromRGBO(255, 204, 39, .7),
            700: Color.fromRGBO(255, 204, 39, .8),
            800: Color.fromRGBO(255, 204, 39, .9),
            900: Color.fromRGBO(255, 204, 39, 1),
          },
        ),
      ),
      home: const HomePage(),
    );
  }
}
