import 'package:flutter/material.dart';

class ReportPage extends State {
  static String title = 'Report';
  String getAppTitle() => title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [Text(title)],
    );
  }
}
