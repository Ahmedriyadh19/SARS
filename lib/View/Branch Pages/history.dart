import 'package:flutter/material.dart';

class HistoryPage extends State {
  static String appBarTitle = 'History';

  String getAppTitle() => appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('History')],
    );
  }
}
