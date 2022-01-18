import 'package:flutter/material.dart';
import 'package:sars/View/Branch%20Pages/history.dart';
import 'package:sars/View/Branch%20Pages/notification_page.dart';
import 'package:sars/View/Branch%20Pages/profile.dart';
import 'package:sars/View/Branch%20Pages/ticket.dart';

class MainPage extends State {
  int selectedPageIndex;
  Function(int i) getSelectedPage;

  MainPage({required this.selectedPageIndex, required this.getSelectedPage});

  @override
  Widget build(BuildContext context) {
    List<Widget> bodys = [
      NotificationPage().build(context),
      HistoryPage().build(context),
      TicketPage().build(context),
      ProfilePage().build(context),
    ];

    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        body: Column(
          
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [bodys[selectedPageIndex]],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedPageIndex,
            selectedFontSize: 10,
            unselectedFontSize: 5,
            type: BottomNavigationBarType.shifting,
            onTap: getSelectedPage,
            selectedItemColor: const Color.fromARGB(255, 35, 61, 82),
            unselectedItemColor: const Color.fromARGB(255, 141, 218, 221),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.access_alarm),
                  backgroundColor: Color.fromARGB(255, 0, 173, 181),
                  label: 'Notification',
                  tooltip: 'Notification'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.access_alarm),
                  backgroundColor: Color.fromARGB(255, 0, 173, 181),
                  label: 'History',
                  tooltip: 'History'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.access_alarm),
                  backgroundColor: Color.fromARGB(255, 0, 173, 181),
                  label: 'Tickit',
                  tooltip: 'Tickit'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.access_alarm),
                  backgroundColor: Color.fromARGB(255, 0, 173, 181),
                  label: 'Profile',
                  tooltip: 'Profile'),
            ]),
      ),
    );
  }
}
/*
  Scaffold(
        appBar: AppBar(
          actions:  [
            Container(
              padding:const EdgeInsets.only(right: 20),
              child: const Icon(Icons.person)
            )
          ],
          elevation: 20,
          backgroundColor: const Color.fromARGB(255, 0, 173, 181),
          title: Container(
            padding: const EdgeInsets.only(left: 90),
            child: const Text(
              'Main Page',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(5.0, 5.0),
                      blurRadius: 20,
                      color: Colors.white,
                    ),
                    Shadow(
                      offset: Offset(5.0, 5.0),
                      blurRadius: 20,
                      color: Colors.white,
                    ),
                  ]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(0, 173, 181, 1),
              Color.fromRGBO(0, 57, 60, 1),
            ],
          )),
          alignment: Alignment.center,
        ))
    ;
*/
