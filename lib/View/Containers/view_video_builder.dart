import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sars/View/BuildWidgetsData/loading.dart';
import 'package:video_player/video_player.dart';

class DisplayVideoScreen extends StatefulWidget {
  final XFile? videoFile;
  final String? videoURL;
  const DisplayVideoScreen({Key? key, this.videoFile, this.videoURL})
      : super(key: key);

  @override
  State<DisplayVideoScreen> createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    File file;
    String url;
    if (widget.videoFile != null) {
      file = File(widget.videoFile!.path);
      super.initState();
      videoPlayerController = VideoPlayerController.file(file)
        ..initialize().then((_) {
          videoPlayerController!.setVolume(1);
          setState(() {});
        });
    } else {
      url = widget.videoURL!;
      super.initState();
      videoPlayerController = VideoPlayerController.network(url)
        ..initialize().then((_) {
          videoPlayerController!.setVolume(1);
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 100;

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
                      ? Container(
                          alignment: Alignment.center,
                          height: height,
                          //width: width,
                          child: Expanded(
                            child: AspectRatio(
                              aspectRatio:
                                  videoPlayerController!.value.size.aspectRatio,
                              child: VideoPlayer(videoPlayerController!),
                            ),
                          ),
                        )
                      : const Center(child: Loading()),
                  Center(
                    child: IconButton(
                      tooltip: 'Play/Pause',
                      iconSize: width,
                      color: Colors.cyanAccent.withOpacity(0),
                      icon: Icon(
                        videoPlayerController!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white.withOpacity(0.1),
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          videoPlayerController!.value.isPlaying
                              ? videoPlayerController!.pause()
                              : videoPlayerController!.play();
                        });
                      },
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
