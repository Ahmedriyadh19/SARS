import 'package:flutter/material.dart';

class TicketPage extends State {
  bool otherActive; //active other input
  bool isTherePictures;
  bool isThereVideo;
  bool chkEverything;
  int currentStep;
  int availableTryPictures;
  String? dropMenuValue;
  String? errorOther;
  String? genrlError;
  List<bool> picturesFound;
  List<String> ticketInfo;
  List<TextEditingController> myController;

  Function() takePictures;
  Function() recordVideo;
  Function() valid;
  Function() onContinue;
  Function() onCancel;
  Function() deleteVideo;
  Function(int index) deletPicture;
  Function(int newIndex) onTapped;
  Function(dynamic value) selectedMenuValue;
  Function() dailog;

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
    return Column(
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
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color:
                                              Colors.black.withOpacity(0.5)))),
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
                                  canvasColor:
                                      const Color.fromARGB(200, 85, 200, 205),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: dropMenuValue,
                                    items: items.map(buildMenuItem).toList(),
                                    onChanged: selectedMenuValue,
                                  ),
                                ),
                              ),
                            ),
                            otherActive
                                ? TextFormField(
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.7)),
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      label: const Text(
                                        'Your Issue',
                                        style: TextStyle(color: Colors.black),
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
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.7)),
                            autocorrect: true,
                            decoration: const InputDecoration(
                                label: Text(
                                  'Description',
                                  style: TextStyle(color: Colors.black),
                                ),
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
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.7)),
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

                            //controller: _Textcontroller,
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
                                            color:
                                                Colors.black.withOpacity(0.01),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 25.0,
                                                backgroundColor: Colors
                                                    .cyanAccent
                                                    .withOpacity(0.5),
                                              ),
                                              title: const Text('Picture 1'),
                                              subtitle: const Text(
                                                  'Click To view it'),
                                              trailing: IconButton(
                                                icon: const Icon(
                                                    Icons.delete_rounded),
                                                onPressed: () {
                                                  deletPicture(0);
                                                },
                                              ),
                                              onTap: () {},
                                            ),
                                          )
                                        : const Text(
                                            '',
                                            style: TextStyle(fontSize: 1),
                                          ),
                                    picturesFound.elementAt(1)
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 3, top: 3),
                                            color:
                                                Colors.black.withOpacity(0.01),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 25.0,
                                                backgroundColor: Colors
                                                    .cyanAccent
                                                    .withOpacity(0.5),
                                              ),
                                              title: const Text('Picture 2'),
                                              subtitle: const Text(
                                                  'Click To view it'),
                                              trailing: IconButton(
                                                icon: const Icon(
                                                    Icons.delete_rounded),
                                                onPressed: () {
                                                  deletPicture(1);
                                                },
                                              ),
                                              onTap: () {},
                                            ),
                                          )
                                        : const Text(
                                            '',
                                            style: TextStyle(fontSize: 1),
                                          ),
                                    picturesFound.elementAt(2)
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 3, top: 3),
                                            color:
                                                Colors.black.withOpacity(0.01),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 25.0,
                                                backgroundColor: Colors
                                                    .cyanAccent
                                                    .withOpacity(0.5),
                                              ),
                                              title: const Text('Picture 3'),
                                              subtitle: const Text(
                                                  'Click To view it'),
                                              trailing: IconButton(
                                                icon: const Icon(
                                                    Icons.delete_rounded),
                                                onPressed: () {
                                                  deletPicture(2);
                                                },
                                              ),
                                              onTap: () {},
                                            ),
                                          )
                                        : const Text(
                                            '',
                                            style: TextStyle(fontSize: 1),
                                          ),
                                    picturesFound.elementAt(3)
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 3, top: 3),
                                            color:
                                                Colors.black.withOpacity(0.01),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 25.0,
                                                backgroundColor: Colors
                                                    .cyanAccent
                                                    .withOpacity(0.5),
                                              ),
                                              title: const Text('Picture 4'),
                                              subtitle: const Text(
                                                  'Click To view it'),
                                              trailing: IconButton(
                                                icon: const Icon(
                                                    Icons.delete_rounded),
                                                onPressed: () {
                                                  deletPicture(3);
                                                },
                                              ),
                                              onTap: () {},
                                            ),
                                          )
                                        : const Text(
                                            '',
                                            style: TextStyle(fontSize: 1),
                                          ),
                                    picturesFound.elementAt(4)
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 3, top: 3),
                                            color:
                                                Colors.black.withOpacity(0.01),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 25.0,
                                                backgroundColor: Colors
                                                    .cyanAccent
                                                    .withOpacity(0.5),
                                              ),
                                              title: const Text('Picture 5'),
                                              subtitle: const Text(
                                                  'Click To view it'),
                                              trailing: IconButton(
                                                icon: const Icon(
                                                    Icons.delete_rounded),
                                                onPressed: () {
                                                  deletPicture(4);
                                                },
                                              ),
                                              onTap: () {},
                                            ),
                                          )
                                        : const Text(
                                            '',
                                            style: TextStyle(fontSize: 1),
                                          ),
                                    picturesFound.elementAt(5)
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 3, top: 3),
                                            color:
                                                Colors.black.withOpacity(0.01),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 25.0,
                                                backgroundColor: Colors
                                                    .cyanAccent
                                                    .withOpacity(0.5),
                                              ),
                                              title: const Text('Picture 6'),
                                              subtitle: const Text(
                                                  'Click To view it'),
                                              trailing: IconButton(
                                                icon: const Icon(
                                                    Icons.delete_rounded),
                                                onPressed: () {
                                                  deletPicture(5);
                                                },
                                              ),
                                              onTap: () {},
                                            ),
                                          )
                                        : const Text(
                                            '',
                                            style: TextStyle(fontSize: 1),
                                          ),
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
                                          ? const Text(
                                              '',
                                              style: TextStyle(fontSize: 1),
                                            )
                                          : IconButton(
                                              icon:
                                                  const Icon(Icons.add_a_photo),
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
                                        color: Colors.black.withOpacity(0.01),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 25.0,
                                            backgroundColor: Colors.cyanAccent
                                                .withOpacity(0.5),
                                          ),
                                          title: const Text('Video'),
                                          subtitle:
                                              const Text('Click To view it'),
                                          trailing: IconButton(
                                            icon: const Icon(
                                                Icons.delete_rounded),
                                            onPressed: () {
                                              deleteVideo();
                                            },
                                          ),
                                          onTap: () {},
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
                    style:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                  )
                : const Text(''),
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
  TicketPage(
      {required this.otherActive,
      required this.isThereVideo,
      required this.deleteVideo,
      required this.recordVideo,
      required this.deletPicture,
      required this.takePictures,
      required this.availableTryPictures,
      required this.isTherePictures,
      required this.chkEverything,
      required this.genrlError,
      required this.currentStep,
      required this.dropMenuValue,
      required this.picturesFound,
      required this.onTapped,
      required this.selectedMenuValue,
      required this.errorOther,
      required this.onContinue,
      required this.onCancel,
      required this.myController,
      required this.ticketInfo,
      required this.dailog,
      required this.valid});
}
