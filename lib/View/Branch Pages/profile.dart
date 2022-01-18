import 'package:flutter/material.dart';

class ProfilePage extends State {
  static String appBarTitle = 'Profile';
  String getAppTitle() => appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('Profile')],
    );
  }
}
