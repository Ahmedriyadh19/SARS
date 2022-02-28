import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/announcement.dart';
import 'package:sars/View/Hold%20data/announcement_holder.dart';

class AnnouncementStreamListener extends State {
  static String title = 'Announcement';
  String getAppTitle() => title;

  @override
  Widget build(BuildContext context) {
    List<Announcement> announcementData2 = [];

    return StreamProvider<List<Announcement>>.value(
        initialData: announcementData2,
        value: DatabaseFeatures().announcementFromFirebase,
        child:  const AnnouncementBuilderPage());
  }
}
