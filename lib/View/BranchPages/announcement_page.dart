import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/announcement.dart';
import 'package:sars/View/BuildWidgetsData/announcement_holder.dart';

class AnnouncementBuilderStreamListener extends StatefulWidget {
  const AnnouncementBuilderStreamListener({Key? key}) : super(key: key);

  @override
  State<AnnouncementBuilderStreamListener> createState() =>
      _AnnouncementStreamListenerState();
}

class _AnnouncementStreamListenerState
    extends State<AnnouncementBuilderStreamListener> {
  @override
  Widget build(BuildContext context) {
    List<Announcement> announcementData2 = [];

    return StreamProvider<List<Announcement>>.value(
        initialData: announcementData2,
        value: DatabaseFeatures().announcementFromFirebase,
        child: const AnnouncementBuilderData());
  }
}
