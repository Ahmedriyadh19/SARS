import 'package:flutter/material.dart';
import 'package:sars/View/Main%20Pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginBuilder(),
    );
  }
}

class LoginBuilder extends StatefulWidget {
  const LoginBuilder({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPage();
}
