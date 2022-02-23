import 'package:cloud_firestore/cloud_firestore.dart' as database_firestore;

import 'package:sars/Model/user.dart';

class DatabaseFeatures {
  final String? uidUser;

  final database_firestore.FirebaseFirestore _databaseCollection =
      database_firestore.FirebaseFirestore.instance;

  DatabaseFeatures({required this.uidUser});

  Future createNewUserInfo(User u) async {
    return await _databaseCollection.collection('user').doc(uidUser).set({
      'name': u.name,
      'email': u.email,
      'address': u.address,
      'role': 'r',
      'pictureUrl': u.pictureUrl,
      'phone': u.phone,
    });
  }
}
