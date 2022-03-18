import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_viewer/video_viewer.dart';

class DisplayVideoScreen extends StatefulWidget {
  final XFile? videoFile;
  final String? videoURL;
  const DisplayVideoScreen({Key? key, this.videoFile, this.videoURL})
      : super(key: key);

  @override
  State<DisplayVideoScreen> createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  final VideoViewerController controller = VideoViewerController();

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
        child: widget.videoURL != null
            ? VideoViewer(
                controller: controller,
                source: {
                  "SubRip Text": VideoSource(
                    video: VideoPlayerController.network(widget.videoURL!),
                  )
                },
              )
            : VideoViewer(
                controller: controller,
                source: {
                  "SubRip Text": VideoSource(
                    video: VideoPlayerController.file(
                        File(widget.videoFile!.path)),
                  )
                },
              ),
      ),
    );
  }

  VideoPlayerController getVideoPlayer() => controller.video!;
  String? getactiveSourceNameName() => controller.activeSourceName;
  String? getActiveCaption() => controller.activeCaption;
  bool isFullScreen() => controller.isFullScreen;
  bool isBuffering() => controller.isBuffering;
  bool isPlaying() => controller.isPlaying;
}
