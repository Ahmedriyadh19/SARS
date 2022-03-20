import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/View/BuildWidgetsData/home_holder.dart';
import 'package:sars/View/BuildWidgetsData/history_holder.dart';

class TicketStreamBuilder extends StatelessWidget {
  const TicketStreamBuilder(
      {Key? key, required this.userID, required this.targetPage})
      : super(key: key);
  final String targetPage;
  final String userID;
  @override
  Widget build(BuildContext context) {
    List<Ticket> ticketData = [];

    return StreamProvider<List<Ticket>?>.value(
        initialData: ticketData,
        value: DatabaseFeatures().ticketFromFirebase,
        child: targetPage == 'Home'
            ? const HomeBuilderData()
            : HistroyBuilderData(uid: userID));
  }
}
