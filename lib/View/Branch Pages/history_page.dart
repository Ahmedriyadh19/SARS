import 'package:flutter/material.dart';

class HistoryPage extends State {
  static String title = 'History';

  String getAppTitle() => title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [Text(title)],
    );
  }
}
