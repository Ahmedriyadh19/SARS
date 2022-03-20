import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/View/BuildWidgetsData/loading.dart';
import 'package:sars/View/Containers/ticket_view_builder.dart';

class HomeBuilderData extends StatefulWidget {
  const HomeBuilderData({Key? key}) : super(key: key);

  @override
  State<HomeBuilderData> createState() => _HomeBuilderDataState();
}

class _HomeBuilderDataState extends State<HomeBuilderData> {
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

    List<Ticket> flilter = [];

    for (var item in ticketData) {
      if (item.privacy == 'Public') {
        flilter.add(item);
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
                  itemCount: flilter.length,
                  itemBuilder: (context, index) {
                    return TicketViewBuilder(
                      ticket: flilter[index],
                      traget: 'Home',
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
