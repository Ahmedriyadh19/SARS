import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SpinKitFadingCube(
      color: Colors.white,
      size: 60.0,
    ));
  }
}


/*  decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromRGBO(0, 173, 181, 1),
          Color.fromRGBO(0, 57, 60, 1),
        ],
      )), */