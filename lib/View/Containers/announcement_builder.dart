import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementBuilder extends StatelessWidget {
  final String contain;
  final String title;
  final DateTime dateTime;

  const AnnouncementBuilder({
    Key? key,
    required this.contain,
    required this.title,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      padding: const EdgeInsets.all(5),
      width: 400,
      height: 200,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ]),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Date: ${DateFormat.yMMMEd().format(dateTime)}',
                            style: const TextStyle(
                              // color: Color.fromARGB(255, 0, 188, 212),
                              fontSize: 20,
                            ))
                      ]),
                ),
                SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: SelectableText(
                        'Announcement: $contain',
                        showCursor: true,
                        toolbarOptions: const ToolbarOptions(copy: true,selectAll: true),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 20),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(colors: [
            Color.fromARGB(240, 169, 225, 228),
            Color.fromARGB(255, 169, 225, 228)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
    );
  }
}
