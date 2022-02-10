import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Model/user.dart';
import 'package:sars/View/Main%20Pages/login_page.dart';
import 'package:sars/View/Main%20Pages/main_page.dart';
//import 'package:sars/View/Main%20Pages/main_page.dart';

class Controller extends StatelessWidget {
  const Controller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    
    //return either home or login
    if (user == null){
      return const LoginBuilder();
    }
    else{
     return const MainPageBuilder();
    }
  }
}
