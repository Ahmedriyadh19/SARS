import 'package:flutter/material.dart';

class NotificationPage extends State {
  static String title = 'Notification';
  String getAppTitle() => title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [Text(title)],
    );
  }
}
