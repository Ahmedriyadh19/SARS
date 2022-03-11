import 'package:flutter/material.dart';
import 'package:sars/Model/user.dart';
import 'package:sars/View/Containers/settings_page.dart';
import 'package:sars/View/Containers/ticket_page.dart';
import 'package:sars/View/StreamBranchPages/announcement_page.dart';
import 'package:sars/View/StreamBranchPages/history_page.dart';
import '../StreamBranchPages/home_page.dart';

class MainPageBuilder extends StatefulWidget {
  final User currentUser;
  const MainPageBuilder({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<MainPageBuilder> createState() => _MainPageBuilderState();
}

class _MainPageBuilderState extends State<MainPageBuilder> {
  int selectedPageIndex = 0;
  String appBarTitle = 'Home';
  List<String> appBarTitles = [
    'Home',
    'Announcement',
    'History',
    'Ticket',
    'Settings'
  ];

  getSelectedPage(int i) {
    setState(() {
      selectedPageIndex = i;
      appBarTitle = appBarTitles[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    User targetUser = widget.currentUser;
    print(targetUser.toString());
    List<Widget> bodies = [
      const HomePageBuilder(),
      const AnnouncementBuilderStreamListener(),
      HistoryPageBuilder(userID: targetUser.uid!),
      TicketBuilderPage(currentUser: targetUser),
      SettingsBuilderPage(userID: targetUser)
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
        actions: [
          CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(targetUser.pictureUrl!)),
        ],
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
