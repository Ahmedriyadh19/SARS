import 'package:flutter/material.dart';
import 'package:sars/Control/Services/auth.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/user.dart';

class SettingsBuilderPage extends StatefulWidget {
  final User userID;
  const SettingsBuilderPage({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<SettingsBuilderPage> createState() => _SettingsBuilderPageState();
}

class _SettingsBuilderPageState extends State<SettingsBuilderPage> {
  
  final DatabaseFeatures _databaseFeatures = DatabaseFeatures();
  final AuthUserMethod _auth = AuthUserMethod();

  @override
  Widget build(BuildContext context) {
   User?  uid = widget.userID;
    _databaseFeatures.uidUser = uid.uid;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Settings'),
        const SizedBox(
          height: 400,
        ),
        ElevatedButton(
          child: const Text(
            'Sign out',
            textAlign: TextAlign.center,
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 141, 218, 221)))),
              elevation: MaterialStateProperty.all(30),
              backgroundColor:
                  MaterialStateProperty.all(const Color.fromARGB(0, 0, 57, 60)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.only(left: 112, right: 112)),
              textStyle:
                  MaterialStateProperty.all(const TextStyle(fontSize: 15))),
          onPressed: () async {
            await _auth.signOutUser();
          },
        ),
      ],
    );
  }
}
