import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/announcement.dart';
import 'package:sars/View/BuildWidgetsData/announcement_holder.dart';

class AnnouncementBuilderStreamListener extends StatelessWidget {
  const AnnouncementBuilderStreamListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Announcement> announcementData = [];

    return StreamProvider<List<Announcement>>.value(
        initialData: announcementData,
        value: DatabaseFeatures().announcementFromFirebase,
        child: const AnnouncementBuilderData());
  }
}
