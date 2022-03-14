import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/View/BuildWidgetsData/ticket_history_holder.dart';


class HistoryPageBuilder extends StatelessWidget {
   const HistoryPageBuilder({Key? key, required this.userID}) : super(key: key);
  final String userID;
  @override
  Widget build(BuildContext context) {
     List<Ticket> ticketData = [];
    
    return StreamProvider<List<Ticket>?>.value(
        initialData: ticketData,
        value: DatabaseFeatures().ticketFromFirebase,
        child: TicketHistroyBuilderData(uid: userID));
   
  }
}