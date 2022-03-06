import 'dart:io';

class Ticket {
  String userId;
  String type;
  String description;
  String? location;
  String? feeddback = '';
  int status;
  int? rate = 0;
  DateTime dateTime;
  List<File>? attachmentsFilesImages = [];
  File? attachmentsFilesVideo;
  List<String>? attachmentsFilesUrlDataImages = [];
  String? attachmentsFilesUrlDataVideo;

  Ticket(
      {required this.userId,
      required this.dateTime,
      required this.status,
      required this.type,
      required this.description,
      this.location,
      this.attachmentsFilesImages,
      this.attachmentsFilesUrlDataImages,
      this.attachmentsFilesUrlDataVideo,
      this.attachmentsFilesVideo,
      this.feeddback,
      this.rate});
}
