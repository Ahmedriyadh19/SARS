import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/View/BuildWidgetsData/ticket_history_holder.dart';

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
    List<Ticket> ticketData = [];
    uid = widget.userID;
    _databaseFeatures.uidUser = uid;
    return StreamProvider<List<Ticket>?>.value(
        initialData: ticketData,
        value: DatabaseFeatures().ticketFromFirebase,
        child: TicketHistroyBuilderData(uid: uid!));
  }
}
