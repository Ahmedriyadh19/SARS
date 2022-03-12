import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sars/Model/user.dart';
import 'package:sars/View/MainPages/main_page.dart';

class PushUserInfo extends StatefulWidget {
  final User userId;

  const PushUserInfo({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<PushUserInfo> createState() => _PushUserInfoState();
}

class _PushUserInfoState extends State<PushUserInfo> {
  @override
  Widget build(BuildContext context) {
    final List<User>? userData = Provider.of<List<User>?>(context);

    for (var item in userData!) {
      if (item.uid == widget.userId.uid) {
        return MainPageBuilder(currentUser: item);
      }
    }
    return Container();
  }
}
