import 'package:flutter/material.dart';

class TicketPage extends State {
  static String title = 'Ticket';
  String getAppTitle() => title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [Text(title)],
    );
  }
}
