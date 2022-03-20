import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/View/BuildWidgetsData/loading.dart';
import 'package:sars/View/Containers/ticket_view_builder.dart';

class HistroyBuilderData extends StatefulWidget {
  final String uid;
  const HistroyBuilderData({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<HistroyBuilderData> createState() =>
      _HistroyBuilderDataState();
}

class _HistroyBuilderDataState extends State<HistroyBuilderData> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double newWidth = MediaQuery.of(context).size.width - 10;
    final String uid = widget.uid;
    final ticketData = Provider.of<List<Ticket>>(context);
    ticketData.sort((b, a) {
      return a.dateTime.compareTo(b.dateTime);
    });

    List<Ticket> flilter = [];

    for (var item in ticketData) {
      if (item.userId == uid) {
        flilter.add(item);
      }
    }

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
                  itemCount: flilter.length,
                  itemBuilder: (context, index) {
                    return TicketViewBuilder(
                      ticket: flilter[index],
                      traget: 'Histroy',
                    );
                  },
                )),
            flilter.isEmpty
                ? const Text('No Ticket Yet',
                    style: TextStyle(fontSize: 20, color: Colors.white))
                : Container()
          ]);
  }
}
