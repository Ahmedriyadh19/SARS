import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementBuilder extends StatelessWidget {
  final String contain;
  final DateTime dateTime;

  const AnnouncementBuilder({
    Key? key,
    required this.contain,
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
                SingleChildScrollView(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Date: ${DateFormat.yMMMEd().format(dateTime)}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 188, 212),
                              fontSize: 20,
                            ))
                      ]),
                ),
                SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Announcement: $contain',
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
          gradient: LinearGradient(colors: [
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(0.2),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    );
  }
}
