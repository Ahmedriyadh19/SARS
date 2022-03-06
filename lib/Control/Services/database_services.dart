import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' as database_firestore;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sars/Model/announcement.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/Model/user.dart';
import 'package:uuid/uuid.dart';

class DatabaseFeatures {
  String? uidUser;

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

  Future pushNewTicket(Ticket t) async {
    Uuid uuid = const Uuid();
    String idTicketG = uuid.v1();
    return await _databaseCollection.collection('ticket').doc(idTicketG).set({
      'dateTime': t.dateTime,
      'description': t.description,
      'typeOfTicket': t.type,
      'status': t.status,
      'location': t.location,
      'userID': uidUser,
    });

    // upLoad return d_p / push itckit
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
}

 Future<List<String>> uploadFiles(List<File> _images) async {
  List<String> imageUrls =
      await Future.wait(_images.map((_image) => uploadFile(_image)));
  return imageUrls;
}

Future<String> uploadFile(File _image) async {
  dynamic storageReference =
      FirebaseStorage.instance.ref().child('posts/${_image.path}');
  dynamic uploadTask = storageReference.putFile(_image);
  await uploadTask.onComplete;
  return await storageReference.getDownloadURL();
}
 