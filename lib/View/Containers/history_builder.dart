import 'package:flutter/material.dart';

import 'package:sars/Model/ticket.dart';

class TicketBuilder extends StatefulWidget {
  final Ticket ticket;
  const TicketBuilder({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  State<TicketBuilder> createState() => _TicketBuilderState();
}

class _TicketBuilderState extends State<TicketBuilder> {
  @override
  Widget build(BuildContext context) {
    final Ticket ticket = widget.ticket;

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      padding: const EdgeInsets.all(5),
      height: 400,
      decoration: targetColorIssue(ticket.status),
      child: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(child: Column(children: [Container()])),
      )),
    );
  }

  targetColorIssue(int status) {
    Color? start;
    Color? end;

    switch (status) {
      case 0:
        start = const Color.fromARGB(240, 169, 225, 228);
        end = const Color.fromARGB(180, 169, 225, 228);
        break;
      default:
    }

    BoxDecoration statusColor = BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(colors: [
          start!, //240
          end!,
          Colors.white.withOpacity(0.6) //180
        ], begin: Alignment.topLeft, end: Alignment.bottomRight));

    return statusColor;
  }
}
