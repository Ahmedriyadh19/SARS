import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/View/BuildWidgetsData/loading.dart';
import 'package:sars/View/Containers/ticket_view_builder.dart';

class HomeBuilderDta extends StatefulWidget {
  const HomeBuilderDta({Key? key}) : super(key: key);

  @override
  State<HomeBuilderDta> createState() => _HomeBuilderDtaState();
}

class _HomeBuilderDtaState extends State<HomeBuilderDta> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double newWidth = MediaQuery.of(context).size.width - 10;
    final ticketData = Provider.of<List<Ticket>>(context);
    ticketData.sort((b, a) {
      return a.dateTime.compareTo(b.dateTime);
    });

    setState(() {
      loading == true;
      if (ticketData.isEmpty || ticketData.isNotEmpty) {
        loading = false;
      }
    });

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
                      traget: 'Home',
                    );
                  },
                )),
            ticketData.isEmpty
                ? const Text('No Ticket Yet',
                    style: TextStyle(fontSize: 20, color: Colors.white))
                : Container()
          ]);
  }
}
