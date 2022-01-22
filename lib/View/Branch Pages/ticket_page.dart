import 'package:flutter/material.dart';

class TicketPage extends State {
  static String title = 'Report';
  int currentStep = 0;
  String? dropMenuValue = "1";
  Function(int newIndex) onTapped;
  Function(dynamic value) selectedMenuValue;
  Function() onContinue;
  Function() onCancel;

  final items = [
    'Improper Surface Grading/Drainage',
    'Improper Electrical Wiring.',
    'Roof Damage.',
    'Heating or cooling system.',
    'Poor Overall Maintenance.',
    'Structurally Related Problems.',
    'Plumbing.',
    'Exteriors.',
    'Others'
  ];
  DropdownMenuItem buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
  TicketPage({
    required this.currentStep,
    this.dropMenuValue,
    required this.onTapped,
    required this.onContinue,
    required this.onCancel,
    required this.selectedMenuValue,
  });

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
          child: Theme(
            data: ThemeData(primarySwatch: Colors.cyan),
            child: Stepper(
                type: StepperType.vertical,
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  if (details.stepIndex < 4) {
                    return Row(
                      children: <Widget>[
                        TextButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(10),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.only(
                                    left: 25, right: 25, bottom: 10, top: 10)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.cyan),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Colors.black.withOpacity(0.5)))),
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
                        child: Container(
                          //padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 141, 218, 221),
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
                      )),
                  Step(
                      title: const Text('Step 2: Description.'),
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
                              hintText: 'Describe your issue.'),
                          minLines: 1,
                          maxLines: 6,
                          keyboardType: TextInputType
                              .multiline, // user keyboard will have a button to move cursor to next line
                          maxLength: 2000,

                          //controller: _Textcontroller,
                        ),
                      )),
                  Step(
                      title: const Text('Step 3: Take pictures.'),
                      content: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.add_a_photo),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_a_photo),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_a_photo),
                                      onPressed: () {},
                                    ),
                                  ]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.add_a_photo),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_a_photo),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_a_photo),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ]),
                      )),
                  Step(
                      title: const Text('Step 4: Record a video.'),
                      content: SingleChildScrollView(
                        child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        
                          IconButton(
                            icon: const Icon(Icons.video_call_rounded),
                            onPressed: () => () {},
                          ),
                        ]),
                      )),
                  Step(
                      title: const Text('Step 5: Submission.'),
                      content: SingleChildScrollView(
                        child: ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                title: const Text('Registration'),
                                contentPadding: const EdgeInsets.all(20.0),
                                backgroundColor:
                                    const Color.fromARGB(255, 85, 200, 205),
                                children: [
                                  const Text(
                                    'The submission has submitted successfully.',
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 15.0),
                                    child: TextButton(
                                      child: const Text(
                                        'Close.',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 18, 49, 85)),
                                      ),
                                      onPressed: () =>
                                          {Navigator.of(context).pop()},
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )),
                ],
                currentStep: currentStep,
                onStepTapped: onTapped,
                onStepContinue: onContinue,
                onStepCancel: onCancel),
          ),
        ),
        const SizedBox(
          height: 250,
        )
      ],
    );
  }
}
