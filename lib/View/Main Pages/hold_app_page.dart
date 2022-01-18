import 'package:flutter/material.dart';
import 'package:sars/View/Main%20Pages/login_page.dart';

class HoldAppPage extends State {
  bool passwordVis = true;

  setVisibility() {
    setState(() {
      passwordVis = !passwordVis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(0, 173, 181, 1),
            Color.fromRGBO(0, 57, 60, 1),
          ],
        )),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginPage(passwordVis: passwordVis, switchVisble: setVisibility)
                  .build(context)
            ],
          ),
        ),
      ),
    );
  }
}
