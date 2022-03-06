import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/View/BuildWidgetsData/loading.dart';
import 'package:video_player/video_player.dart';
import 'package:sars/View/Containers/view_image_builder.dart';
import 'package:sars/View/Containers/view_video_builder.dart';

class TicketBuilderPage extends StatefulWidget {
  final String userID;
  const TicketBuilderPage({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<TicketBuilderPage> createState() => _TicketBuilderPageState();
}

class _TicketBuilderPageState extends State<TicketBuilderPage> {
  bool otherActive = false;
  bool isTherePictures = false;
  bool chkEverything = false;
  bool isThereVideo = false;
  bool loading = false;
  bool? cameraGetimage;
  bool? cameraGetvideo;
  List<bool> picturesFound = [false, false, false, false, false, false];
  List<File> images = [];
  XFile? videoFile;
  int selectedPageIndex = 0;
  int currentStep = 0;
  int availableTryPictures = -1;
  String? dropMenuValue = 'Plumbing';
  String? errorOther;
  String? genrlError;
  String? descriptionError;
  String? uid;
  VideoPlayerController? videoPlayerController;
  ImagePicker imagePicker = ImagePicker();
  final filter = ProfanityFilter();
  final DatabaseFeatures _databaseFeatures = DatabaseFeatures();
  final List<TextEditingController> myController =
      List.generate(3, (i) => TextEditingController());

  final items = [
    'Improper Surface Grading/Drainage',
    'Improper Electrical Wiring',
    'Roof Damage',
    'Heating or cooling system',
    'Poor Overall Maintenance',
    'Structurally Related Problems',
    'Plumbing',
    'Exteriors',
    'Facilities',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    double newWidth = MediaQuery.of(context).size.width - 50;
    uid = widget.userID;
    _databaseFeatures.uidUser = uid;
    return loading
        ? const Loading()
        : Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              Container(
                width: newWidth,
                padding: const EdgeInsets.only(left: 0, right: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.1)),
                child: Column(children: [
                  Theme(
                    data: ThemeData(primarySwatch: Colors.cyan),
                    child: Stepper(
                        type: StepperType.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        controlsBuilder:
                            (BuildContext context, ControlsDetails details) {
                          if (details.stepIndex < 5) {
                            return Row(
                              children: <Widget>[
                                TextButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.only(
                                            left: 25,
                                            right: 25,
                                            bottom: 10,
                                            top: 10)),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.cyan),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.5)))),
                                  ),
                                  onPressed: details.onStepContinue,
                                  child: const Text(
                                    'CONTINUE',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                TextButton(
                                  onPressed: details.onStepCancel,
                                  child: const Text(
                                    'CANCEL',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Row();
                          }
                        },
                        elevation: 50,
                        steps: [
                          Step(
                              title: const Text('Step 1: Type of Issue'),
                              content: SingleChildScrollView(
                                child: Column(children: [
                                  Container(
                                    //padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 141, 218, 221),
                                            width: 1)),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: const Color.fromARGB(
                                            200, 85, 200, 205),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: dropMenuValue,
                                          items:
                                              items.map(buildMenuItem).toList(),
                                          onChanged: selectedMenuValue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  otherActive
                                      ? TextFormField(
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.7)),
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                            label: const Text(
                                              'Your Issue',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            hintText: 'Type your issue',
                                            errorText: errorOther,
                                          ),
                                          minLines: 1,
                                          maxLines: 6,
                                          keyboardType: TextInputType
                                              .multiline, // user keyboard will have a button to move cursor to next line
                                          maxLength: 50,
                                          controller: myController[0],
                                        )
                                      : const Text(''),
                                ]),
                              )),
                          Step(
                              title: const Text('Step 2: Description'),
                              content: SingleChildScrollView(
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                      label: const Text(
                                        'Description',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      errorText: descriptionError,
                                      hintText: 'Describe your issue'),
                                  minLines: 1,
                                  maxLines: 6,
                                  keyboardType: TextInputType
                                      .multiline, // user keyboard will have a button to move cursor to next line
                                  maxLength: 2000,
                                  controller: myController[1],
                                ),
                              )),
                          Step(
                              title: const Text('Step 3: Location'),
                              content: SingleChildScrollView(
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                  autocorrect: true,
                                  decoration: const InputDecoration(
                                      label: Text(
                                        'Location',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      hintText: 'Locate your issue'),
                                  minLines: 1,
                                  maxLines: 2,
                                  keyboardType: TextInputType
                                      .multiline, // user keyboard will have a button to move cursor to next line
                                  maxLength: 50,
                                  controller: myController[2],
                                ),
                              )),
                          Step(
                              title: const Text('Step 4: Take pictures'),
                              content: SingleChildScrollView(
                                child: Column(children: [
                                  isTherePictures
                                      ? Column(children: [
                                          picturesFound.elementAt(0)
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 3, top: 3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      color: Colors.black
                                                          .withOpacity(0.1)),
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage:
                                                          FileImage(images
                                                              .elementAt(0)),
                                                      radius: 25.0,
                                                      backgroundColor: Colors
                                                          .cyanAccent
                                                          .withOpacity(0.5),
                                                    ),
                                                    title:
                                                        const Text('Picture 1'),
                                                    subtitle: const Text(
                                                        'Click To view it'),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                          Icons.delete_rounded),
                                                      onPressed: () {
                                                        deletPicture(0);
                                                      },
                                                    ),
                                                    onTap: () {
                                                      viewPicture(0);
                                                    },
                                                  ),
                                                )
                                              : Container(),
                                          picturesFound.elementAt(1)
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 3, top: 3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      color: Colors.black
                                                          .withOpacity(0.1)),
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      radius: 25.0,
                                                      backgroundImage:
                                                          FileImage(images
                                                              .elementAt(1)),
                                                      backgroundColor: Colors
                                                          .cyanAccent
                                                          .withOpacity(0.5),
                                                    ),
                                                    title:
                                                        const Text('Picture 2'),
                                                    subtitle: const Text(
                                                        'Click To view it'),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                          Icons.delete_rounded),
                                                      onPressed: () {
                                                        deletPicture(1);
                                                      },
                                                    ),
                                                    onTap: () {
                                                      viewPicture(1);
                                                    },
                                                  ),
                                                )
                                              : Container(),
                                          picturesFound.elementAt(2)
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 3, top: 3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      color: Colors.black
                                                          .withOpacity(0.1)),
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage:
                                                          FileImage(images
                                                              .elementAt(2)),
                                                      radius: 25.0,
                                                      backgroundColor: Colors
                                                          .cyanAccent
                                                          .withOpacity(0.5),
                                                    ),
                                                    title:
                                                        const Text('Picture 3'),
                                                    subtitle: const Text(
                                                        'Click To view it'),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                          Icons.delete_rounded),
                                                      onPressed: () {
                                                        deletPicture(2);
                                                      },
                                                    ),
                                                    onTap: () {
                                                      viewPicture(2);
                                                    },
                                                  ),
                                                )
                                              : Container(),
                                          picturesFound.elementAt(3)
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 3, top: 3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      color: Colors.black
                                                          .withOpacity(0.1)),
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage:
                                                          FileImage(images
                                                              .elementAt(3)),
                                                      radius: 25.0,
                                                      backgroundColor: Colors
                                                          .cyanAccent
                                                          .withOpacity(0.5),
                                                    ),
                                                    title:
                                                        const Text('Picture 4'),
                                                    subtitle: const Text(
                                                        'Click To view it'),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                          Icons.delete_rounded),
                                                      onPressed: () {
                                                        deletPicture(3);
                                                      },
                                                    ),
                                                    onTap: () {
                                                      viewPicture(3);
                                                    },
                                                  ),
                                                )
                                              : Container(),
                                          picturesFound.elementAt(4)
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 3, top: 3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      color: Colors.black
                                                          .withOpacity(0.1)),
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage:
                                                          FileImage(images
                                                              .elementAt(4)),
                                                      radius: 25.0,
                                                      backgroundColor: Colors
                                                          .cyanAccent
                                                          .withOpacity(0.5),
                                                    ),
                                                    title:
                                                        const Text('Picture 5'),
                                                    subtitle: const Text(
                                                        'Click To view it'),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                          Icons.delete_rounded),
                                                      onPressed: () {
                                                        deletPicture(4);
                                                      },
                                                    ),
                                                    onTap: () {
                                                      viewPicture(4);
                                                    },
                                                  ),
                                                )
                                              : Container(),
                                          picturesFound.elementAt(5)
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 3, top: 3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      color: Colors.black
                                                          .withOpacity(0.1)),
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage:
                                                          FileImage(images
                                                              .elementAt(5)),
                                                      radius: 25.0,
                                                      backgroundColor: Colors
                                                          .cyanAccent
                                                          .withOpacity(0.5),
                                                    ),
                                                    title:
                                                        const Text('Picture 6'),
                                                    subtitle: const Text(
                                                        'Click To view it'),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                          Icons.delete_rounded),
                                                      onPressed: () {
                                                        deletPicture(5);
                                                      },
                                                    ),
                                                    onTap: () {
                                                      viewPicture(5);
                                                    },
                                                  ),
                                                )
                                              : Container()
                                        ])
                                      : const Text(
                                          '',
                                          style: TextStyle(fontSize: 1),
                                        ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            availableTryPictures >= 5
                                                ? Container()
                                                : IconButton(
                                                    icon: const Icon(
                                                        Icons.add_a_photo),
                                                    onPressed: () {
                                                      takePictures();
                                                    },
                                                  ),
                                          ],
                                        ),
                                      ]),
                                ]),
                              )),
                          Step(
                              title: const Text('Step 5: Record a video'),
                              content: SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      isThereVideo
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 3, top: 3),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: Colors.black
                                                      .withOpacity(0.1)),
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: const AssetImage(
                                                      'assets/icons/icons8_video_96px.png'),
                                                  radius: 25.0,
                                                  backgroundColor: Colors
                                                      .cyanAccent
                                                      .withOpacity(0.1),
                                                ),
                                                title: const Text('Video'),
                                                subtitle: const Text(
                                                    'Click To view it'),
                                                trailing: IconButton(
                                                  icon: const Icon(
                                                      Icons.delete_rounded),
                                                  onPressed: () {
                                                    deleteVideo();
                                                  },
                                                ),
                                                onTap: () {
                                                  viewVideo();
                                                },
                                              ),
                                            )
                                          : IconButton(
                                              icon: const Icon(
                                                  Icons.video_call_rounded),
                                              onPressed: () {
                                                recordVideo();
                                              },
                                            )
                                    ]),
                              )),
                          Step(
                              title: const Text('Step 6: Submission'),
                              content: SingleChildScrollView(
                                child: ElevatedButton(
                                  child: const Text('Submit'),
                                  onPressed: () {
                                    dailog();
                                  },
                                ),
                              )),
                        ],
                        currentStep: currentStep,
                        onStepTapped: onTapped,
                        onStepContinue: onContinue,
                        onStepCancel: onCancel),
                  ),
                  chkEverything
                      ? Text(
                          genrlError!,
                          style: const TextStyle(
                              color: Colors.redAccent, fontSize: 15),
                        )
                      : Container(),
                  const SizedBox(height: 15),
                ]),
              ),
              const SizedBox(
                height: 250,
              )
            ],
          );
  }

  DropdownMenuItem buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );

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
      loading = true;
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
      if (chk1) {
        getInitialized();
      }
    });
    return chk1;
  }

  getInitialized() {
    try {
      String cleanString = filter.censor(myController[1].text);
      String typeOfIssue;

      if (myController[0].text.isEmpty) {
        typeOfIssue = dropMenuValue!;
      } else {
        typeOfIssue = myController[0].text;
      }
      Ticket _ticket = Ticket(
        dateTime: DateTime.now(),
        description: cleanString,
        userId: uid!,
        type: typeOfIssue,
        status: 0,
        location: myController[2].text,
        attachmentsFilesImages: images,
      );

      if (isThereVideo) {
        _ticket.attachmentsFilesVideo = File(videoFile!.path);
      }

      submitTicket(_ticket);
    } catch (e) {
      genrlError = e.toString();
    }
  }

  submitTicket(Ticket _ticket) async {
    getInitialized();
    await _databaseFeatures.pushNewTicket(_ticket);
  }

  dailog() {
    if (valid()) {
      setDefault();
      setState(() {
        loading = false;
      });
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
    } else {
      setState(() {
        loading = false;
      });
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
