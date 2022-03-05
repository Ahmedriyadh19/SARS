import 'package:flutter/material.dart';

class HistoryPageBuilder extends StatefulWidget {
  const HistoryPageBuilder({Key? key}) : super(key: key);

  @override
  State<HistoryPageBuilder> createState() => _HistoryPageBuilderState();
}

class _HistoryPageBuilderState extends State<HistoryPageBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('History')],
    );
  }
}
