import 'package:flutter/material.dart';
import 'package:sars/Model/user.dart';
import 'package:sars/View/Containers/settings_container.dart';
import 'package:sars/View/Containers/ticket_container.dart';
import 'package:sars/View/Streams/announcement_stream.dart';
import 'package:sars/View/Streams/ticket_stream.dart';

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
    List<Widget> bodies = [
      TicketStreamBuilder(userID: targetUser.uid!, targetPage: 'Home'),
      const AnnouncementBuilderStreamListener(),
      TicketStreamBuilder(userID: targetUser.uid!, targetPage: 'History'),
      TicketContainer(currentUser: targetUser),
      Settingscontainer(user: targetUser)
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: const Color.fromARGB(255, 0, 173, 181),
        title: Container(
          margin: const EdgeInsets.only(left: 50),
          child: Center(
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
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                getSelectedPage(4);
              },
              child: CircleAvatar(
                  backgroundImage: NetworkImage(targetUser.pictureUrl!),
                  backgroundColor: Colors.black.withOpacity(0.1)),
            ),
          ),
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
            Color.fromARGB(218, 0, 170, 179),
            Color.fromARGB(172, 66, 239, 248),
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
