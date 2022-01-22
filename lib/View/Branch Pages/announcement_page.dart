import 'package:flutter/material.dart';

class AnnouncementPage extends State {
  static String title = 'Announcement';
  String getAppTitle() => title;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children:  [Text(title)],
    );
  }
}
