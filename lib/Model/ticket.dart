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
  List<File>? attachmentsFiles = [];
  List<String>? attachmentsFilesUrlData = [];
  
  Ticket(
      {required this.userId,
      required this.dateTime,
      required this.status,
      required this.type,
      required this.description,
      this.location,
      this.attachmentsFiles,
      this.attachmentsFilesUrlData,
      this.feeddback,
      this.rate});
}
