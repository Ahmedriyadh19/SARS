import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sars/View/BuildWidgetsData/loading.dart';

class DisplayPictureScreen extends StatelessWidget {
  final File? imagePath;
  final String? url;
  final int? number;

  const DisplayPictureScreen({Key? key, this.imagePath, this.number, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 20,
          backgroundColor: const Color.fromARGB(255, 0, 173, 181),
          title: Center(
            child: Text(
              'Display Picture ${number! + 1}',
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
            child: url == null
                ? Center(
                    child: InteractiveViewer(child: Image.file((imagePath!))),
                  )
                : Center(
                    child: InteractiveViewer(
                        child: Image.network(
                      url!,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Loading();
                      },
                      errorBuilder: (context, error, stackTrace) => const Text(
                        'Some errors occurred!',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
                  )));
  }
}
