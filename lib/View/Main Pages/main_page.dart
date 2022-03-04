import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sars/View/Branch%20Pages/history_page.dart';
import 'package:sars/View/Branch%20Pages/announcement_page.dart';
import 'package:sars/View/Branch%20Pages/home_page.dart';
import 'package:sars/View/Branch%20Pages/settings_page.dart';
import 'package:sars/View/Branch%20Pages/ticket_page.dart';
import 'package:sars/View/Containers/view_image.dart';
import 'package:sars/View/Containers/view_video.dart';
import 'package:video_player/video_player.dart';

class MainPageBuilder extends StatefulWidget {
  const MainPageBuilder({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPage();
}

class MainPage extends State {
  bool otherActive = false;
  bool isTherePictures = false;
  bool chkEverything = false;
  bool isThereVideo = false;
  bool? cameraGetimage;
  bool? cameraGetvideo;
  List<bool> picturesFound = [false, false, false, false, false, false];
  List<String> ticketInfo = [];
  List<File> images = [];
  XFile? videoFile;
  int selectedPageIndex = 0;
  int currentStep = 0;
  int availableTryPictures = -1;
  String? dropMenuValue;
  String? errorOther;
  String? genrlError;
  String? descriptionError;
  String appBarTitle = 'Home';
  VideoPlayerController? videoPlayerController;
  ImagePicker imagePicker = ImagePicker();

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
        isThereVideo: isThereVideo,
        availableTryPictures: availableTryPictures,
        isTherePictures: isTherePictures,
        chkEverything: chkEverything,
        genrlError: genrlError,
        currentStep: currentStep,
        errorOther: errorOther,
        myController: myController,
        picturesFound: picturesFound,
        otherActive: otherActive,
        images: images,
        videoFile: videoFile,
        dropMenuValue: dropMenuValue,
        descriptionError: descriptionError,
        viewPicture: viewPicture,
        viewVideo: viewVideo,
        dailog: dailog,
        deleteVideo: deleteVideo,
        recordVideo: recordVideo,
        deletPicture: deletPicture,
        valid: valid,
        onCancel: onCancel,
        onContinue: onContinue,
        onTapped: onTapped,
        takePictures: takePictures,
        selectedMenuValue: selectedMenuValue,
      ).build(context),
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

  deleteVideo() {
    setState(() {
      isThereVideo = false;
      videoFile = null;
    });
  }

  onCancel() {
    setState(() {
      if (currentStep == 0) {
        myController[0].clear();
        dropMenuValue = null;
        otherActive = false;
        errorOther = null;
      }
      if (currentStep == 1) {
        myController[1].clear();
      }
      if (currentStep == 2) {
        myController[2].clear();
      }
      if (currentStep == 3) {
        deleteAllPicture();
      }
      if (currentStep == 4) {
        deleteVideo();
      }
      if (currentStep != 0) {
        currentStep -= 1;
      }
    });
  }

  deleteAllPicture() {
    setState(() {
      availableTryPictures = -1;
      isTherePictures = false;
      for (int i = 0; i < picturesFound.length; i++) {
        picturesFound[i] = false;
        images.clear();
      }
    });
  }

  recordVideo() async {
    await getVideoFromCamara();
    if (cameraGetvideo == true) {
      setState(() {
        isThereVideo = true;
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

  takePictures() async {
    await getImageFromCamera();
    if (cameraGetimage == true) {
      setState(() {
        availableTryPictures++;
        picturesFound[availableTryPictures] = true;
        if (availableTryPictures < 0) {
          isTherePictures = false;
        } else {
          isTherePictures = true;
        }
      });
    }
  }

  viewVideo() async {
    try {
      await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => DisplayVideoScreen(
                  videoFile: videoFile!,
                )),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.

    }
  }

  viewPicture(int index) async {
    try {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DisplayPictureScreen(
            imagePath: images.elementAt(index),
            number: index,
          ),
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.

    }
  }

  deletPicture(int index) {
    setState(() {
      picturesFound.removeAt(index);
      images.removeAt(index);
      picturesFound.add(false);
      availableTryPictures--;
      cameraGetimage = false;
    });
  }

  bool valid() {
    bool chk1 = true;
    chkEverything = false;
    genrlError = '';
    errorOther = null;
    descriptionError = null;
    setState(() {
      if (myController[0].text.isEmpty && dropMenuValue == 'Other') {
        errorOther = 'You can not leave the type of issus empty';
        chk1 = false;
        chkEverything = true;
        currentStep = 0;
      }
      if (dropMenuValue == null) {
        genrlError = 'Must choose your type of issue';
        currentStep = 0;
        chk1 = false;
        chkEverything = true;
      }
      if (myController[1].text.isEmpty) {
        descriptionError = 'Must write your description of issue';
        currentStep = 1;
        chk1 = false;
        chkEverything = true;
      }
    });
    return chk1;
  }

  dailog() {
    if (valid()) {
      setDefault();
      return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: const Text('Ticket'),
          contentPadding: const EdgeInsets.all(20.0),
          backgroundColor: const Color.fromARGB(255, 85, 200, 205),
          children: [
            const Text(
              'The Ticket has submitted successfully.',
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: TextButton(
                child: const Text(
                  'Close',
                  style: TextStyle(color: Color.fromARGB(255, 18, 49, 85)),
                ),
                onPressed: () => {Navigator.of(context).pop()},
              ),
            )
          ],
        ),
      );
    }
  }

  setDefault() {
    setState(() {
      otherActive = false;
      isTherePictures = false;
      chkEverything = false;
      isThereVideo = false;
      cameraGetimage = false;
      cameraGetvideo = false;
      currentStep = 0;
      availableTryPictures = -1;
      dropMenuValue = null;
      errorOther = null;
      genrlError = null;
      descriptionError = null;
      videoFile = null;

      for (int i = 0; i < picturesFound.length; i++) {
        picturesFound[i] = false;
      }
      for (int i = 0; i < myController.length; i++) {
        myController[i].clear();
      }
      images.clear();
    });
  }

  Future getImageFromCamera() async {
    cameraGetimage = false;
    final image = await (imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 65));
    if (image != null && image.path.isNotEmpty) {
      images.add(File(image.path));
      cameraGetimage = true;
    }
  }

  getVideoFromCamara() async {
    cameraGetvideo = false;
    XFile? video = await imagePicker.pickVideo(
        source: ImageSource.camera, maxDuration: const Duration(seconds: 60));
    if (video != null && video.path.isNotEmpty) {
      videoFile = video;
      cameraGetvideo = true;
    }
  }
}
