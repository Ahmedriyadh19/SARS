import 'package:flutter/material.dart';
import 'package:sars/Control/Services/database_services.dart';

class HistoryPageBuilder extends StatefulWidget {
  final String userID;

  const HistoryPageBuilder({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<HistoryPageBuilder> createState() => _HistoryPageBuilderState();
}

class _HistoryPageBuilderState extends State<HistoryPageBuilder> {
  String? uid;
  final DatabaseFeatures _databaseFeatures = DatabaseFeatures();
  @override
  Widget build(BuildContext context) {
    uid = widget.userID;
    _databaseFeatures.uidUser = uid;
    return Column(
      children: const [Text('History')],
    );
  }
}
