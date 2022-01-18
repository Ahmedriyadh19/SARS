import 'package:flutter/material.dart';
import 'package:sars/View/Main%20Pages/login_page.dart';
import 'package:sars/View/Main%20Pages/main_page.dart';
import 'package:sars/View/Main%20Pages/registration_page.dart';

class HoldAppPage extends State {
  bool passwordVis = true;
  bool passwordVis2 = true;
  int selectedPageIndex = 0;

  setVisibility() {
    setState(() {
      passwordVis = !passwordVis;
    });
  }

  setVisibility2() {
    setState(() {
      passwordVis2 = !passwordVis2;
    });
  }

  void getSelectedPage(int i) {
    setState(() {
      selectedPageIndex = i;
    });
  }

   goToMain(BuildContext bctx) {
     Navigator.of(bctx).push(MaterialPageRoute(builder: (BuildContext context) {
            return  MainPage(getSelectedPage: getSelectedPage,selectedPageIndex: selectedPageIndex).build(context);
    }));
  }

   goToReg(BuildContext bctx) {
    Navigator.of(bctx).push(MaterialPageRoute(builder: (BuildContext context) {
      return Registration(
              passwordVis2: passwordVis2,
              passwordVis: passwordVis,
              setVisibility2: setVisibility2,
              setVisibility: setVisibility)
          .build(context);
    }));
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
              LoginPage(
                  switchVisble: setVisibility,
                  passwordVis: passwordVis,
                  goToMain: () => goToMain(context),
                  goToReg: () => goToReg(context)).build(context),
            ],
          ),
        ),
      ),
    );
  }
}
