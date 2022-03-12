import 'dart:io';

class Ticket {
  String? userName;
  String userId;
  String type;
  String description;
  String location;
  String feeddback = '';
  int status;
  int rate = 0;
  int? privacy = 1;
  DateTime dateTime;
  List<File> attachmentsFiles = [];
  List<String> attachmentsFilesUrlData = [];

  Ticket(
      {required this.userId,
      required this.dateTime,
      required this.status,
      required this.type,
      required this.description,
      required this.location,
      required this.attachmentsFiles,
      required this.attachmentsFilesUrlData,
      required this.feeddback,
      required this.rate,
      this.privacy,
      this.userName});

  @override
  String toString() {
    return 'Ticket(privacy: $privacy, userName: $userName, userId: $userId, type: $type, description: $description, location: $location, feeddback: $feeddback, status: $status, rate: $rate, dateTime: $dateTime, attachmentsFiles: $attachmentsFiles, attachmentsFilesUrlData: $attachmentsFilesUrlData)';
  }
}
