import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sars/Model/ticket.dart';
import 'package:sars/View/BuildWidgetsData/loading.dart';
import 'package:sars/View/Containers/history_builder.dart';

class TicketHistroyBuilderData extends StatefulWidget {
  final String uid;
  const TicketHistroyBuilderData({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<TicketHistroyBuilderData> createState() =>
      _TicketHistroyBuilderDataState();
}

class _TicketHistroyBuilderDataState extends State<TicketHistroyBuilderData> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double newWidth = MediaQuery.of(context).size.width - 10;
    final String uid = widget.uid;
    final ticketData = Provider.of<List<Ticket>>(context);
    ticketData.sort((b, a) {
      return a.dateTime.compareTo(b.dateTime);
    });
    List filter = [];
    for (var item in ticketData) {
      if (item.userId == uid) {
        filter.add(item);
      }
    }

    return loading
        ? const Loading()
        : Column(children: [
            SizedBox(
                width: newWidth,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filter.length,
                  itemBuilder: (context, index) {
                    return TicketBuilder(
                      ticket: filter[index],
                    );
                  },
                )),
            filter.isEmpty
                ? const Text('No Ticket Yet',
                    style: TextStyle(fontSize: 20, color: Colors.white))
                : Container()
          ]);
  }
}
