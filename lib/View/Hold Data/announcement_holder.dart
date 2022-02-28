import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Model/announcement.dart';
import 'package:sars/View/Containers/announcement_builder.dart';

class AnnouncementBuilderPage extends StatelessWidget {
  const AnnouncementBuilderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double newWidth = MediaQuery.of(context).size.width - 20;
    final announcementData = Provider.of<List<Announcement>>(context);
    return announcementData.isNotEmpty
        ? SizedBox(
            width: newWidth,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: announcementData.length,
                itemBuilder: (context, index) {
                  return AnnouncementBuilder(
                    announcement: announcementData[index],
                  );
                }),
          )
        : const Text('No Announcement Yet...',
            style: TextStyle(fontSize: 30, color: Colors.white));
  }
}
