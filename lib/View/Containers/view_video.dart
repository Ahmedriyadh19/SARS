import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class DisplayVideoScreen extends StatefulWidget {
  final XFile videoFile;
  const DisplayVideoScreen({
    Key? key,
    required this.videoFile,
  }) : super(key: key);

  @override
  State<DisplayVideoScreen> createState() => DisplayVideoScreenState();
}

class DisplayVideoScreenState extends State<DisplayVideoScreen> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    File file = File(widget.videoFile.path);

    super.initState();
    videoPlayerController = VideoPlayerController.file(file)
      ..initialize().then((_) {
        videoPlayerController!.setVolume(0.5);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 20,
          backgroundColor: const Color.fromARGB(255, 0, 173, 181),
          title: const Center(
            child: Text(
              'Display Video',
              style: TextStyle(
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
              child: SingleChildScrollView(
                child: Stack(alignment: Alignment.center, children: [
                  videoPlayerController!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio:
                              videoPlayerController!.value.size.aspectRatio,
                          child: VideoPlayer(videoPlayerController!),
                        )
                      : Container(),
                  Center(
                    child: FloatingActionButton(
                      backgroundColor: Colors.cyanAccent.withOpacity(0),
                      tooltip: 'Play/Pause',
                      onPressed: () {
                        setState(() {
                          videoPlayerController!.value.isPlaying
                              ? videoPlayerController!.pause()
                              : videoPlayerController!.play();
                        });
                      },
                      child: Icon(
                        videoPlayerController!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.cyanAccent.withOpacity(0),
                        size: 200,
                      ),
                    ),
                  ),
                ]),
              ),
            )));
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController!.dispose();
  }
}
