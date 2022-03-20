import 'package:flutter/material.dart';
import 'package:sars/Control/Services/auth.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/user.dart';

class Settingscontainer extends StatefulWidget {
  final User userID;
  const Settingscontainer({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<Settingscontainer> createState() => _SettingsBuilderPageState();
}

class _SettingsBuilderPageState extends State<Settingscontainer> {
  final DatabaseFeatures _databaseFeatures = DatabaseFeatures();
  final AuthUserMethod _auth = AuthUserMethod();

  @override
  Widget build(BuildContext context) {
    User? currentUser = widget.userID;
    _databaseFeatures.uidUser = currentUser.uid;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'Update Profile',
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 25),
        GestureDetector(
          child: CircleAvatar(
              backgroundImage: NetworkImage(currentUser.pictureUrl!),
              maxRadius: 60,
              backgroundColor: Colors.black.withOpacity(0.1)),
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.black.withOpacity(0.5),
              elevation: 10,
              builder: (_) {
                return Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(0, 173, 181, 0.6),
                        Color.fromRGBO(0, 57, 60, 0.6),
                      ],
                    )),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(Icons.camera_alt_rounded),
                            Icon(Icons.photo_library_rounded)
                          ]),
                    ));
              },
            );
          },
        ),
        const SizedBox(height: 20),
        Row(children: const [
          Expanded(
              child: Divider(
            indent: 60,
            endIndent: 20,
            color: Colors.black,
          )),
          Text(
            "Sign out",
            style: TextStyle(color: Colors.black),
          ),
          Expanded(
              child: Divider(
            indent: 20,
            endIndent: 60,
            color: Colors.black,
          )),
        ]),
        const SizedBox(height: 30),
        ElevatedButton(
          child: const Text(
            'Sign out',
            textAlign: TextAlign.center,
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    9.0), /* side: const BorderSide(color: Colors.black) */
              )),
              elevation: MaterialStateProperty.all(20),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(185, 226, 21, 21)),
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
