import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      height: 300,
      decoration: targetColorIssue(ticket.status),
      child: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              SingleChildScrollView(
                child: Container(
                    // decoration: getBorderForAll(),
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      DateFormat.yMMMMEEEEd().add_jm().format(ticket.dateTime),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )),
              ),
              SingleChildScrollView(
                child: Container(
                    decoration: getBorderForAll(),
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Ticket Status: ${targetStatus(ticket.status)}',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    )),
              ),
              Container(
                  decoration: getBorderForAll(),
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Ticket Issue: ${ticket.type}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )),
              Container(
                  decoration: getBorderForAll(),
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Ticket Description: ${ticket.description}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )),
              ticket.location.isNotEmpty
                  ? Container(
                      decoration: getBorderForAll(),
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Ticket Location: ${ticket.location}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ))
                  : Container(),
              ticket.attachmentsFilesUrlData.isNotEmpty
                  ? SingleChildScrollView(
                      child: Container(
                      decoration: getBorderForAll(),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(4),
                      child: Column(children: [
                        Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Attachments:',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )),
                        Container(
                          //if there Is images
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(10),
                          child: SingleChildScrollView(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [],
                          )),
                        ),
                      ]),
                    ))
                  : Container(),
              ticket.status == 0
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(4, 4, 30, 4),
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        alignment: Alignment.bottomRight,
                        icon: const Icon(
                          Icons.cancel_rounded,
                          color: Colors.red,
                          size: 50,
                        ),
                        onPressed: () {},
                      ),
                    )
                  : Container()
            ])),
      )),
    );
  }

  targetColorIssue(int status) {
    Color? start;
    Color? end;
    Color? mid;

    switch (status) {
      case 0:
        start = Colors.grey.withOpacity(0.4);
        mid = Colors.grey.withOpacity(0.7);
        end = Colors.grey.withOpacity(0.3);
        break;
      case 1:
        start = Colors.blue.withOpacity(0.4);
        mid = Colors.blue.withOpacity(0.7);
        end = Colors.blue.withOpacity(0.3);
        break;
      case 2:
        start = Colors.green.withOpacity(0.4);
        mid = Colors.green.withOpacity(0.7);
        end = Colors.green.withOpacity(0.3);
        break;
      case 3:
        start = Colors.red.withOpacity(0.4);
        mid = Colors.red.withOpacity(0.7);
        end = Colors.red.withOpacity(0.3);
        break;
      case 4:
        start = Colors.deepOrange.withOpacity(0.4);
        mid = Colors.deepOrange.withOpacity(0.7);
        end = Colors.deepOrange.withOpacity(0.3);
        break;
      default:
        {
          start = Colors.purple.withOpacity(0.4);
          mid = Colors.purple.withOpacity(0.7);
          end = Colors.purple.withOpacity(0.3);
        }
    }

    BoxDecoration statusColor = BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            colors: [start, mid, end],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight));

    return statusColor;
  }

  getBorderForAll() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color.fromARGB(120, 169, 225, 228));
  }

  targetStatus(int status) {
    List<String> statusText = [
      'Pending',
      'Approved',
      'Complete',
      'Rejected',
      'Canceled',
      'I Dont Know'
    ];
    return statusText.elementAt(status);
  }
}
