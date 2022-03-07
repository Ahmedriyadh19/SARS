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
    return Text(ticket.type);
  }
}
