import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:sars/Control/Controller/build_user_info.dart';
import 'package:sars/Model/user.dart';
import 'package:sars/View/MainPages/login_page.dart';
import 'package:sars/View/MainPages/main_page.dart';

class Controller extends StatelessWidget {
  const Controller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);

    //return either home or login
    if (_user == null) {
      return const LoginBuilder();
    } else {
      return MainPageBuilder(userId: _user);
      //return BuildUserInfoStream(userId: _user);
    }
  }
}
