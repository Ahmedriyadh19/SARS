import 'package:flutter/material.dart';

import 'package:sars/View/Branch%20Pages/history_page.dart';
import 'package:sars/View/Branch%20Pages/announcement_page.dart';
import 'package:sars/View/Branch%20Pages/home_page.dart';
import 'package:sars/View/Branch%20Pages/settings_page.dart';
import 'package:sars/View/Branch%20Pages/ticket_page.dart';

class MainPageBuilder extends StatefulWidget {
  const MainPageBuilder({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPage();
}

class MainPage extends State {
  String appBarTitle = 'Home';
  int selectedPageIndex = 0;
  int currentStep = 0;
  String? dropMenuValue;

  onTapped(int newIndex) {
    setState(() {
      currentStep = newIndex;
    });
  }

  onContinue() {
    if (currentStep != 4) {
      setState(() {
        currentStep += 1;
      });
    }
  }

  onCancel() {
    if (currentStep != 0) {
      setState(() {
        currentStep -= 1;
      });
    }
  }

  selectedMenuValue(value) {
    setState(() {
      dropMenuValue = value;
    });
  }

  List<String> appBarTitles = [
    'Home',
    'Announcement',
    'History',
    'Ticket',
    'Settings'
  ];
  void getSelectedPage(int i) {
    setState(() {
      selectedPageIndex = i;
      appBarTitle = appBarTitles[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    
    List<Widget> bodies = [
      HomePage().build(context),
      AnnouncementStreamListener().build(context),
      HistoryPage().build(context),
      TicketPage(
              onCancel: onCancel,
              onContinue: onContinue,
              onTapped: onTapped,
              currentStep: currentStep,
              selectedMenuValue: selectedMenuValue,
              dropMenuValue: dropMenuValue)
          .build(context),
      SettingsPage().build(context),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: const Color.fromARGB(255, 0, 173, 181),
        title: Center(
          child: Text(
            appBarTitle,
            style: const TextStyle(
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
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(0, 173, 181, 1),
            Color.fromRGBO(0, 57, 60, 1),
          ],
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [bodies[selectedPageIndex]],
            ),
          ),
        ),
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
                icon: Icon(Icons.home_rounded),
                backgroundColor: Color.fromARGB(255, 0, 173, 181),
                label: 'Home',
                tooltip: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                backgroundColor: Color.fromARGB(255, 0, 173, 181),
                label: 'Announcement',
                tooltip: 'Announcement'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history),
                backgroundColor: Color.fromARGB(255, 0, 173, 181),
                label: 'History',
                tooltip: 'History'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                backgroundColor: Color.fromARGB(255, 0, 173, 181),
                label: 'Report',
                tooltip: 'Report'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                backgroundColor: Color.fromARGB(255, 0, 173, 181),
                label: 'Settings',
                tooltip: 'Settings'),
          ]),
    );
  }
}
