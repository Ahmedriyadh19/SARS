import 'package:flutter/material.dart';
import 'package:sars/View/Main%20Pages/login_page.dart';
//import 'package:sars/View/Main%20Pages/main_page.dart';

class Controller extends StatelessWidget {
  const Controller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return either home or login
    return const LoginBuilder();
  }
}
