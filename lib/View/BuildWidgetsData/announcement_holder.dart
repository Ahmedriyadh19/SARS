import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Model/announcement.dart';
import 'package:sars/View/Containers/announcement_builder.dart';
import 'package:sars/View/MainPages/loading.dart';


class AnnouncementBuilderData extends StatefulWidget {
  const AnnouncementBuilderData({Key? key}) : super(key: key);

  @override
  State<AnnouncementBuilderData> createState() =>
      _AnnouncementBuilderDatatate();
}

class _AnnouncementBuilderDatatate extends State<AnnouncementBuilderData> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double newWidth = MediaQuery.of(context).size.width - 20;
    final announcementData = Provider.of<List<Announcement>>(context);
    announcementData.sort((b, a) {
      return a.dateTime.compareTo(b.dateTime);
    });

    // get last 30 announcementData
    if (announcementData.length > 30) {
      announcementData.getRange(0, 30);
    }

    setState(() {
      loading = true;
      if (announcementData.isNotEmpty || announcementData.isNotEmpty) {
        loading = false;
      }
    });

    return loading
        ? const Loading()
        : Column(children: [
            SizedBox(
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
            ),
            announcementData.isEmpty
                ? const Text('No Announcement Yet',
                    style: TextStyle(fontSize: 20, color: Colors.white))
                : Container()
          ]);
  }
}
