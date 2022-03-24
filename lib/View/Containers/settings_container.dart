import 'package:flutter/material.dart';
import 'package:sars/Control/Services/auth.dart';
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/user.dart';
import 'package:sars/View/MainPages/forget_password.dart';

class Settingscontainer extends StatefulWidget {
  final User user;
  const Settingscontainer({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<Settingscontainer> createState() => _SettingsBuilderPageState();
}

class _SettingsBuilderPageState extends State<Settingscontainer> {
  final DatabaseFeatures _databaseFeatures = DatabaseFeatures();
  final AuthUserMethod _auth = AuthUserMethod();

  @override
  Widget build(BuildContext context) {
    User? currentUser = widget.user;
    _databaseFeatures.uidUser = currentUser.uid;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 40),
        const Text(
          'Update Profile',
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 25),
        GestureDetector(
          child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            const Icon(Icons.edit),
            CircleAvatar(
                backgroundImage: NetworkImage(currentUser.pictureUrl!),
                maxRadius: 60,
                backgroundColor: Colors.black.withOpacity(0.1)),
          ]),
          onTap: () async {
            await showUpdateSheet();
          },
        ),
        const SizedBox(height: 15),
        InkWell(
          child: const Text(
            'Update Password',
            style: TextStyle(
              color: Color.fromARGB(255, 3, 7, 243),
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () async =>
              {await ForgetPassword().showBottomBoxForgetPass(context)},
        ),
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.black.withOpacity(0.4)),
          child: Column(children: [
            const SizedBox(height: 10),
            lableTemp('Name:'),
            fields(
              lable: currentUser.name,
              hints: 'Update your name',
              icons: const Icon(
                Icons.person_rounded,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            lableTemp('Email:'),
            fields(
              lable: currentUser.email,
              hints: 'Update your email',
              icons: const Icon(
                Icons.email_rounded,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            lableTemp('Phone:'),
            fields(
              lable: currentUser.phone,
              hints: 'Update your phone',
              icons: const Icon(
                Icons.phone_android_rounded,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            lableTemp('Address:'),
            fields(
              lable: currentUser.address,
              hints: 'Update your address',
              icons: const Icon(
                Icons.location_city_rounded,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 10),
            updateBtn()
          ]),
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
            'Sign out',
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

  Future showUpdateSheet() async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0.1),
      elevation: 10,
      builder: (_) {
        return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(218, 0, 170, 179),
                Color.fromARGB(172, 66, 239, 248),
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
  }

  fields({String? lable, String? hints, Icon? icons}) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 169, 225, 228)),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          icon: icons,
          labelText: lable,
          hintText: hints,
          labelStyle: const TextStyle(color: Colors.black),
          iconColor: Colors.black,
        ),
        keyboardType: TextInputType.name,
      ),
    );
  }

  lableTemp(String l) {
    return Container(
        margin: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
        alignment: Alignment.topLeft,
        child: Text(l));
  }

  updateBtn() {
    return ElevatedButton(
      child: const Text(
        'Update',
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
              MaterialStateProperty.all(const Color.fromARGB(200, 0, 0, 0)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.only(left: 112, right: 112)),
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 15))),
      onPressed: () {},
    );
  }
}
