import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' as database_firestore;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sars/Model/announcement.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/Model/user.dart';

class DatabaseFeatures {
  String? uidUser;
  static int x = 0;

  final database_firestore.FirebaseFirestore _databaseCollection =
      database_firestore.FirebaseFirestore.instance;

  DatabaseFeatures({this.uidUser});

  Future createNewUserInfo(User u) async {
    return await _databaseCollection.collection('user').doc(uidUser).set({
      'name': u.name,
      'email': u.email,
      'address': u.address,
      'role': 'r',
      'pictureUrl': '',
      'phone': u.phone,
    });
  }

  Future<List<String>> uploadFiles(List<File> _attachmentsTicket) async {
    List<String> imageUrls = await Future.wait(
        _attachmentsTicket.map((_attachment) => uploadFile(_attachment)));
    return imageUrls;
  }

  Future<String> uploadFile(File _attachment) async {
    String shortenPath = _attachment.path.split('com.services.sars/cache')[1];
    dynamic storageReference = FirebaseStorage.instance
        .ref()
        .child('/resident/attachmentsTickets/$shortenPath');
    dynamic uploadTask = storageReference.putFile(_attachment);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future pushNewTicket(Ticket t) async {
    if (t.attachmentsFiles.isNotEmpty) {
      t.attachmentsFilesUrlData = await uploadFiles(t.attachmentsFiles);
    }
    return await _databaseCollection.collection('ticket').doc().set({
      'dateTime': database_firestore.Timestamp.fromDate(t.dateTime),
      'description': t.description,
      'typeOfTicket': t.type,
      'status': t.status,
      'location': t.location,
      'attachments': t.attachmentsFilesUrlData,
      'feedback': t.feeddback,
      'rate': t.rate,
      'userID': uidUser,
    });
  }

  List<Announcement> announcementListData(
      database_firestore.QuerySnapshot snp) {
    return snp.docChanges.map((data) {
      return Announcement(
          dateTime: DateTime.tryParse(data.doc['date']) ?? DateTime.now(),
          contain: data.doc['description'] ?? '',
          title: data.doc['title'] ?? '');
    }).toList();
  }

  Stream<List<Announcement>> get announcementFromFirebase {
    return _databaseCollection
        .collection('announcement')
        .snapshots()
        .map(announcementListData);
  }

  List<Ticket> ticketListData(database_firestore.QuerySnapshot snp) {
    return snp.docChanges.map(
      (data) {
        return Ticket(
            attachmentsFilesUrlData: data.doc['attachments'] ?? [],
            dateTime: DateTime.tryParse(data.doc['DateTIme']) ?? DateTime.now(),
            description: data.doc['description'] ?? '',
            feeddback: data.doc['feedback'] ?? '',
            location: data.doc['location'] ?? '',
            rate: data.doc['rate'] ?? '',
            status: data.doc['status'] ?? '',
            type: data.doc['typeOfTicket'] ?? '',
            attachmentsFiles: [],
            userId: data.doc['userID'] ?? '');
      },
    ).toList();
  }

  Stream<List<Ticket>> get ticketFromFirebase {
    return _databaseCollection
        .collection('ticket')
        .snapshots()
        .map(ticketListData);
  }
}
