import 'package:flutter/material.dart';

class NotificationPage extends State {
  static String appBarTitle = 'Notification';
  String getAppTitle() => appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('Notification')],
    );
  }
}
