import 'package:cloud_firestore/cloud_firestore.dart' as database_firestore;
import 'package:sars/Model/announcement.dart';
import 'package:sars/Model/user.dart';

class DatabaseFeatures {
  final String? uidUser;

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
