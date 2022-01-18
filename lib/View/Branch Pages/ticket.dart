import 'package:flutter/material.dart';

class TicketPage extends State {
  static String appBarTitle = 'Ticket';
  String getAppTitle() => appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('Ticket')],
    );
  }
}
