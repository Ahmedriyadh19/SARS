import 'package:flutter/material.dart';
import 'package:sars/View/Main%20Pages/hold_app_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ControlFull(),
    );
  }
}

class ControlFull extends StatefulWidget {
  const ControlFull({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HoldAppPage();
}
