import 'package:flutter/material.dart';

class HistoryPage extends State {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromRGBO(0, 173, 181, 1),
          Color.fromRGBO(0, 57, 60, 1),
        ],
      )),
      alignment: Alignment.center,
      child: Column(
        children: const [Text('History')],
      ),
    );
  }
}
