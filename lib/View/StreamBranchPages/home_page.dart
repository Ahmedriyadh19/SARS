import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/View/BuildWidgetsData/home_holder.dart';

class HomePageBuilder extends StatelessWidget {
  const HomePageBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ticket> ticketData = [];
    return StreamProvider<List<Ticket>?>.value(
        initialData: ticketData,
        value: DatabaseFeatures().ticketFromFirebase,
        child: const HomeBuilderDta());
  }
}
