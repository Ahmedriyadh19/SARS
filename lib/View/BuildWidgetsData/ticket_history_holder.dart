import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/View/BuildWidgetsData/loading.dart';
import 'package:sars/View/Containers/history_builder.dart';

class TicketHistroyBuilderData extends StatefulWidget {
  const TicketHistroyBuilderData({Key? key}) : super(key: key);

  @override
  State<TicketHistroyBuilderData> createState() =>
      _TicketHistroyBuilderDataState();
}

class _TicketHistroyBuilderDataState extends State<TicketHistroyBuilderData> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    double newWidth = MediaQuery.of(context).size.width - 10;
    final ticketData = Provider.of<List<Ticket>>(context);
    return loading
        ? const Loading()
        : Column(children: [
            SizedBox(
                width: newWidth,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ticketData.length,
                  itemBuilder: (context, index) {
                    return TicketBuilder(
                      ticket: ticketData[index],
                    );
                  },
                )),
            ticketData.isEmpty
                ? const Text('No Tickit Yet',
                    style: TextStyle(fontSize: 20, color: Colors.white))
                : Container()
          ]);
  }
}
