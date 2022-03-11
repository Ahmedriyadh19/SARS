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
      'fullname': u.name,
      'email': u.email,
      'address': u.address,
      'role': 'r',
      'phonenumber': u.phone,
      'profilePictureURL':
          'gs://sars-e6e88.appspot.com/resident/profile/icons8_users_500px.png',
      'gender': u.gander,
      'secret': u.secret,
      'username': u.userName,
      'userID': uidUser
    });
  }

  Future<List<String>> uploadFiles(List<File> _attachmentsTicket) async {
    List<String> imageUrls = await Future.wait(
        _attachmentsTicket.map((_attachment) => uploadFile(_attachment)));
    return imageUrls;
  }

  Future<String> uploadFile(File _attachment) async {
    String shortenPath = _attachment.path.split('com.services.sars/cache')[1];
    dynamic storageReference;
    if (shortenPath.contains('.jpg')) {
      storageReference =
          FirebaseStorage.instance.ref().child('/resident/images/$shortenPath');
    } else {
      storageReference =
          FirebaseStorage.instance.ref().child('/resident/video/$shortenPath');
    }
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
      'userName': t.userName
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
            attachmentsFilesUrlData: List<String>.from(data.doc['attachments']),
            dateTime: DateTime.parse(data.doc['dateTime'].toDate().toString()),
            description: data.doc['description'] ?? '',
            feeddback: data.doc['feedback'] ?? '',
            location: data.doc['location'] ?? '',
            rate: data.doc['rate'] ?? 0,
            status: data.doc['status'] ?? 0,
            type: data.doc['typeOfTicket'] ?? '',
            attachmentsFiles: [],
            userName: data.doc['userName'],
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

  List<User> getUserFromFirebase(database_firestore.QuerySnapshot snp) {
    return snp.docChanges.map(
      (e) {
        return User(
          address: e.doc['address'] ?? '',
          name: e.doc['fullname'] ?? '',
          phone: e.doc['phonenumber'] ?? '',
          password: e.doc['secret'] ?? '',
          pictureUrl: e.doc['profilePictureURL'] ?? '',
          email: e.doc['email'] ?? '',
          role: e.doc['role'] ?? '',
          gander: e.doc['gender'] ?? '',
          secret: e.doc['secret'] ?? '',
          userName: e.doc['username'] ?? '',
          uid: e.doc['userID']??''
        );
      },
    ).toList();
  }

  Stream<List<User>> get getUserInfo {
    return _databaseCollection
        .collection('user')
        .snapshots()
        .map(getUserFromFirebase);
  }
}
