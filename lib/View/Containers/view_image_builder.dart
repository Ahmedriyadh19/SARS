import 'dart:io';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final File imagePath;
  final int number;

  const DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 20,
          backgroundColor: const Color.fromARGB(255, 0, 173, 181),
          title: Center(
            child: Text(
              'Display Picture ${number + 1}',
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
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(0, 173, 181, 1),
                Color.fromRGBO(0, 57, 60, 1),
              ],
            )),
            alignment: Alignment.center,
            child: Center(
              child: InteractiveViewer(child: Image.file((imagePath))),
            )));
  }
}
