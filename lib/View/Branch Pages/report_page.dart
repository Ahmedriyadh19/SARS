import 'package:flutter/material.dart';

class ReportPage extends State {
  static String title = 'Report';
  Function(int newIndex) onTapped;
  Function() onContinue;
  Function() onCancel;
  int currentStep = 0;
  ReportPage({
    required this.onTapped,
    required this.onContinue,
    required this.onCancel,
    required this.currentStep,
  });  
  String getAppTitle() => title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Stepper(
            elevation: 50,
            steps: [
              Step(title: const Text('Step 1'), content: Container()),
              Step(title: const Text('Step 2'), content: Container()),
              Step(title: const Text('Step 3'), content: Container()),
              Step(title: const Text('Step 4'), content: Container()),
              Step(title: const Text('Step 5'), content: Container()),
            ],
            currentStep: currentStep,
            onStepTapped: onTapped,
            onStepContinue: onContinue,
            onStepCancel:onCancel
          ),
        ),
      ),
    );
  }
}
