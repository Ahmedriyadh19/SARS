import 'package:flutter/material.dart';
import 'package:sars/Control/contorl.dart';

class ProfilePage extends State {
  static String title = 'Settings';
  String getAppTitle() => title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(title),
        const SizedBox(
          height: 400,
        ),
        ElevatedButton(
          child: const Text(
            'Logout',
            textAlign: TextAlign.center,
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 141, 218, 221)))),
              elevation: MaterialStateProperty.all(30),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(0, 0, 57, 60)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.only(left: 112, right: 112)),
              textStyle:
                  MaterialStateProperty.all(const TextStyle(fontSize: 15))),
          onPressed: () => {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const ControlFull(),
            ))
          },
        ),
      ],
    );
  }
}
