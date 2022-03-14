import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/user.dart';
import 'package:sars/View/BuildWidgetsData/loading.dart';
import 'package:sars/View/MainPages/login_page.dart';
import 'package:sars/View/MainPages/main_page.dart';

class Controller extends StatefulWidget {
  const Controller({Key? key}) : super(key: key);

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  User? targetUser;

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    //return either home or login
    if (_user != null) {
      //return const LoginBuilder();
      return FutureBuilder<User>(
          future: DatabaseFeatures(uidUser: _user.uid).getTarget(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return MainPageBuilder(currentUser: snapshot.data!);
            } else if (snapshot.hasError) {
              return const LoginBuilder();
            }
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
                    child: snapshot.connectionState == ConnectionState.waiting
                        ? const Loading()
                        : Container()));
          }));
    }
    return const LoginBuilder();
  }
}
