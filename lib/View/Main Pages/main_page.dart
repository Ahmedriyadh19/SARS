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
  static bool otherActive = false;
  bool isTherePictures = false;
  static List<bool> picturesFound = [false, false, false, false, false, false];
  List<int> indexPicturesFound = [0, 1, 2, 3, 4, 5];
  List<String> ticketInfo = [];
  int selectedPageIndex = 0;
  int currentStep = 0;
  int availableTry = -1;
  String? dropMenuValue;
  String? errorOther;
  String? genrlError;
  bool chk = false;

  static final List<TextEditingController> myController =
      List.generate(3, (i) => TextEditingController());

  List<String> appBarTitles = [
    'Home',
    'Announcement',
    'History',
    'Ticket',
    'Settings'
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> bodies = [
      HomePage().build(context),
      AnnouncementStreamListener().build(context),
      HistoryPage().build(context),
      TicketPage(
              ticketInfo: ticketInfo,
              availableTry: availableTry,
              isTherePictures: isTherePictures,
              chk: chk,
              genrlError: genrlError,
              currentStep: currentStep,
              errorOther: errorOther,
              myController: myController,
              picturesFound: picturesFound,
              otherActive: otherActive,
              deletPicture: deletPicture,
              valid: valid,
              onCancel: onCancel,
              onContinue: onContinue,
              onTapped: onTapped,
              controlAvailableTry: controlAvailableTry,
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

  onTapped(int newIndex) {
    setState(() {
      currentStep = newIndex;
    });
  }

  onContinue() {
    if (currentStep != 5) {
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
      if (value == 'Other') {
        otherActive = true;
      } else {
        otherActive = false;
      }
    });
  }

  getSelectedPage(int i) {
    setState(() {
      selectedPageIndex = i;
      appBarTitle = appBarTitles[i];
    });
  }

  controlAvailableTry() {
    setState(() {
      availableTry++;
      picturesFound[availableTry] = true;
      if (availableTry < 0) {
        isTherePictures = false;
      } else {
        isTherePictures = true;
      }
    });
  }

  deletPicture(int index) {
    setState(() {
      picturesFound.removeAt(index);
      picturesFound.add(false);
      availableTry--;
    });
  }

  bool valid() {
    bool chk1 = true;
    chk = false;
    genrlError = '';
    errorOther = null;
    setState(() {
      if (myController[0].text.isEmpty && dropMenuValue == 'Other') {
        errorOther = 'You can not leave the type of issus empty';
        chk1 = false;
        chk = true;
        currentStep = 0;
      }
      if (dropMenuValue == null) {
        genrlError = 'Must choose your type of issue';
        chk1 = false;
        chk = true;
      }
    });
    return chk1;
  }
}
