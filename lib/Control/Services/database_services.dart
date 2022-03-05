import 'package:cloud_firestore/cloud_firestore.dart' as database_firestore;
import 'package:sars/Model/announcement.dart';
import 'package:sars/Model/ticket.dart';
import 'package:sars/Model/user.dart';

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
    return await _databaseCollection.collection('ticket').doc().set({
      'dateTime':t.dateTime,
      'description': t.description,
      'typeOfTicket': t.type,
      'status': t.status,
      'location': t.location,
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
}
