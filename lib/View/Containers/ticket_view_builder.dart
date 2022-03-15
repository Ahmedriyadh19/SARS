import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/View/Containers/view_image_builder.dart';

class TicketBuilder extends StatefulWidget {
  final Ticket ticket;
  final String? traget;
  const TicketBuilder({
    Key? key,
    required this.ticket,
    this.traget,
  }) : super(key: key);

  @override
  State<TicketBuilder> createState() => _TicketBuilderState();
}

class _TicketBuilderState extends State<TicketBuilder> {
  Ticket? ticket;
  @override
  Widget build(BuildContext context) {
    ticket = widget.ticket;
    String isHome = widget.traget!;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      padding: const EdgeInsets.all(5),
      height: 400,
      decoration: targetColorIssue(ticket!.status),
      child: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              isHome == 'Home'
                  ? SingleChildScrollView(
                      child: Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(10),
                          child: Text(ticket!.userName!)))
                  : Container(),
              SingleChildScrollView(
                  child: Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          DateFormat.yMMMMEEEEd()
                              .add_jm()
                              .format(ticket!.dateTime),
                          style: const TextStyle(
                            fontSize: 18,
                          )))),
              SingleChildScrollView(
                child: getContainerForAll(Text(
                  'Ticket Status: ${targetStatus(ticket!.status)}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )),
              ),
              getContainerForAll(Text(
                'Ticket Issue: ${ticket!.type}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              )),
              getContainerForAll(Text(
                'Ticket Description: ${ticket!.description}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              )),
              ticket!.location.isNotEmpty
                  ? getContainerForAll(Text(
                      'Ticket Location: ${ticket!.location}',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ))
                  : Container(),
              ticket!.attachmentsImagesUrlData.isNotEmpty
                  ? SingleChildScrollView(
                      child: getContainerForAll(Column(children: [
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
                            child: SingleChildScrollView(
                              child: Column(children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      ticket!.attachmentsImagesUrlData.length,
                                  itemBuilder: (context, index) {
                                    return viewImage(index);
                                  },
                                )
                              ]),
                            ),
                          ))
                    ])))
                  : Container(),
              isHome == 'Home'
                  ? Container()
                  : ticket!.status == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                              IconButton(
                                alignment: Alignment.bottomRight,
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                onPressed: () {
                                  showBottomBox();
                                },
                              ),
                              IconButton(
                                alignment: Alignment.bottomRight,
                                icon: const Icon(
                                  Icons.cancel_rounded,
                                  color: Colors.red,
                                  size: 40,
                                ),
                                onPressed: () {
                                  showBottomBox();
                                },
                              ),
                            ])
                      : Container()
            ])),
      )),
    );
  }

  showBottomBox() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0.5),
      elevation: 10,
      builder: (_) {
        return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(206, 97, 239, 247),
                Color.fromARGB(240, 219, 232, 233),
              ],
            )),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      autocorrect: true,
                      decoration: const InputDecoration(
                          label: Text(
                            'Why do you want to cancel the ticket?',
                            style: TextStyle(color: Colors.black),
                          ),
                          hintText: 'Enter your reason'),
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType
                          .multiline, // user keyboard will have a button to move cursor to next line
                      maxLength: 200,
                    ),
                    ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () {},
                    ),
                  ]),
            ));
      },
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

  Container getContainerForAll(Widget contentContainer) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(10),
        child: contentContainer,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color.fromARGB(120, 169, 225, 228)));
  }

  targetStatus(int status) {
    List<String> statusText = [
      'Pending',
      'Approved',
      'Complete',
      'Rejected',
      'Canceled',
    ];
    return statusText.elementAt(status);
  }

  viewImage(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3, top: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.black.withOpacity(0.1)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              NetworkImage(ticket!.attachmentsImagesUrlData.elementAt(index)),
          radius: 25.0,
          backgroundColor: Colors.black.withOpacity(0.4),
        ),
        title: Text('Picture ${index + 1}'),
        subtitle: const Text('Click To view it'),
        onTap: () {
          viewPicture(index);
        },
      ),
    );
  }

  viewPicture(int index) async {
    try {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DisplayPictureScreen(
            url: ticket!.attachmentsImagesUrlData.elementAt(index),
            number: index,
          ),
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.

    }
  }
}
