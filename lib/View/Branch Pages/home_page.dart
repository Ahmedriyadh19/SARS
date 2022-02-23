import 'package:flutter/material.dart';

class HomePage extends State {
  static String title = 'Home';

  String getAppTitle() => title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(title)],
    );
  }
}
