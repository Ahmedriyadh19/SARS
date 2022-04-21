import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  State<Settingscontainer> createState() => SettingsBuilderPageState();
}

class SettingsBuilderPageState extends State<Settingscontainer> {
  User? currentUser;
  final DatabaseFeatures _databaseFeatures = DatabaseFeatures();
  final AuthUserMethod _auth = AuthUserMethod();
  ImagePicker imagePicker = ImagePicker();
  bool done = true;
  int waitingForPassword = 0;
  static String errorMsg = '';
  static List<String?> erorrTexts = List.generate(5, (i) => null);
  static final List<TextEditingController> myController =
      List.generate(5, (i) => TextEditingController());

  static setMsgErrorNull() {
    for (int i = 0; i < erorrTexts.length; i++) {
      erorrTexts[i] = null;
      errorMsg = '';
    }
  }

  static setMyControllerNull() {
    for (int i = 0; i < myController.length; i++) {
      myController[i].clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      currentUser = widget.user;
    });

    _databaseFeatures.uidUser = currentUser!.uid;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 40),
        const Text(
          'Update Profile',
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 25),
        imageContainer(),
        const SizedBox(height: 15),
        InkWell(
          child: const Text(
            'Update Password',
            style: TextStyle(
              color: Color.fromARGB(255, 3, 7, 243),
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () async => {
            await ForgetPassword()
                .showBottomBoxForgetPass(context, u: currentUser)
          },
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
            fields(
                val: 'Name:',
                lable: currentUser!.name,
                hints: 'Update your name',
                icons: const Icon(
                  Icons.person_rounded,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                control: myController[0],
                error: erorrTexts[0],
                input: TextInputType.name),
            fields(
                val: 'Email:',
                lable: currentUser!.email,
                hints: 'Update your email',
                icons: const Icon(
                  Icons.email_rounded,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                control: myController[1],
                error: erorrTexts[1],
                input: TextInputType.emailAddress),
            fields(
                val: 'Phone: ',
                lable: currentUser!.phone,
                hints: 'Update your phone',
                icons: const Icon(
                  Icons.phone_android_rounded,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                control: myController[3],
                error: erorrTexts[3],
                input: TextInputType.phone),
            fields(
                val: 'Address:',
                lable: currentUser!.address,
                hints: 'Update your address',
                icons: const Icon(
                  Icons.location_city_rounded,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                control: myController[4],
                error: erorrTexts[4],
                input: TextInputType.name),
            const SizedBox(height: 10),
            Text(errorMsg),
            const SizedBox(height: 10),
            updateBtn(),
            const SizedBox(height: 10),
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
        signoutBtn(),
        const SizedBox(height: 20)
      ],
    );
  }

  signoutBtn() {
    return ElevatedButton(
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
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(185, 226, 21, 21)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.only(left: 112, right: 112)),
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 15))),
      onPressed: () async {
        await _auth.signOutUser();
      },
    );
  }

  Future showUpdateImageSheet(BuildContext context) async {
    bool imageHasforUpd = false;
    File? updateImage;

    Future getImageFromCamera() async {
      imageHasforUpd = false;
      final image = await (imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 25));
      if (image != null && image.path.isNotEmpty) {
        updateImage = File(image.path);
        imageHasforUpd = true;
      } else {
        imageHasforUpd = false;
      }
    }

    Future getImageFromGallery() async {
      imageHasforUpd = false;
      final image = await (imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 25));
      if (image != null && image.path.isNotEmpty) {
        updateImage = File(image.path);
        imageHasforUpd = true;
      } else {
        imageHasforUpd = false;
      }
    }

    getUpdateImageContainer(StateSetter x) {
      return GestureDetector(
        child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
          const Icon(Icons.remove_circle_rounded),
          CircleAvatar(
              backgroundImage: FileImage(updateImage!),
              maxRadius: 60,
              backgroundColor: Colors.black.withOpacity(0.1)),
        ]),
        onTap: () {
          x(() {
            imageHasforUpd = false;
          });
        },
      );
    }

    updateBtnImage() {
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
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 15))),
        onPressed: () async {
          await _databaseFeatures.updateUserIMageProfile(updateImage!);
          setState(() {
            currentUser!.pictureUrl = _databaseFeatures.getURlImage();
          });
          Navigator.of(context).pop();
        },
      );
    }

    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0.1),
      elevation: 10,
      builder: (context) {
        return StatefulBuilder(builder: (
          BuildContext context,
          StateSetter setStateUpdate,
        ) {
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
                child: imageHasforUpd == false
                    ? Container(
                        margin: const EdgeInsets.all(25),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 169, 225, 228)),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.camera_alt_rounded),
                                    onPressed: () async {
                                      await getImageFromCamera();
                                      setStateUpdate(
                                          () => (imageHasforUpd = true));
                                    }),
                                IconButton(
                                    icon:
                                        const Icon(Icons.photo_library_rounded),
                                    onPressed: () async {
                                      await getImageFromGallery();
                                      setStateUpdate(
                                          () => (imageHasforUpd = true));
                                    }),
                              ]),
                        ]),
                      )
                    : updateImage != null && updateImage!.path.isNotEmpty
                        ? Column(
                            children: [
                              getUpdateImageContainer(setStateUpdate),
                              const SizedBox(height: 10),
                              updateBtnImage()
                            ],
                          )
                        : Container(
                            margin: const EdgeInsets.all(25),
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:
                                    const Color.fromARGB(255, 169, 225, 228)),
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        icon: const Icon(
                                            Icons.camera_alt_rounded),
                                        onPressed: () async {
                                          await getImageFromCamera();
                                          setStateUpdate(
                                              () => (imageHasforUpd = true));
                                        }),
                                    IconButton(
                                        icon: const Icon(
                                            Icons.photo_library_rounded),
                                        onPressed: () async {
                                          await getImageFromGallery();
                                          setStateUpdate(
                                              () => (imageHasforUpd = true));
                                        }),
                                  ]),
                            ]),
                          ),
              ));
        });
      },
    );
  }

  fields(
      {String? val,
      String? lable,
      String? hints,
      Icon? icons,
      TextEditingController? control,
      String? error,
      TextInputType? input}) {
    return Column(children: [
      Container(
          margin: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
          alignment: Alignment.topLeft,
          child: Text(val!)),
      Container(
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
            errorText: error,
            labelStyle: const TextStyle(color: Colors.black),
            iconColor: Colors.black,
          ),
          keyboardType: input,
          controller: control,
        ),
      ),
    ]);
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
      onPressed: () {
        validity();
      },
    );
  }

  validity() async {
    waitingForPassword = 0;
    done = false;
    if (currentUser!.name != myController[0].text &&
        myController[0].text.trim().isNotEmpty) {
      await _databaseFeatures.updateUserName(myController[0].text.trim());
      setState(() {
        currentUser!.name = myController[0].text.trim();
        done = true;
      });
    }
    if (currentUser!.address != myController[4].text &&
        myController[4].text.trim().isNotEmpty) {
      await _databaseFeatures.updateUserAddress(myController[4].text.trim());
      setState(() {
        currentUser!.address = myController[4].text;
        done = true;
      });
    }

    if (currentUser!.phone != myController[3].text &&
        myController[3].text.trim().isNotEmpty) {
      if (myController[3].text.trim().length < 15 &&
          myController[3].text.trim().length > 8) {
        await _databaseFeatures.updateUserPhone(myController[3].text);
        setState(() {
          currentUser!.phone = myController[3].text;
          done = true;
        });
      } else {
        setState(() {
          erorrTexts[3] = 'Phone is invalid';
          waitingForPassword = 2;
          done = false;
        });
      }
    }

    if (currentUser!.email != myController[1].text &&
        myController[1].text.trim().isNotEmpty) {
      String email = myController[1].text.trim();
      final bool isValid = EmailValidator.validate(email);
      if (isValid) {
        setState(() {
          waitingForPassword = 1;
          done = true;
        });
      } else {
        setState(() {
          erorrTexts[1] = 'Email is invalid';
          waitingForPassword = 2;
          done = false;
        });
      }
    }

    if (waitingForPassword == 0 && done) {
      await updateUserDialog();
    } else if ((waitingForPassword == 1 && done) &&
        (myController[3].text.isEmpty)) {
      await askUserPasswordDialog();
    } else {
      null;
    }
  }

  getUpdateUser() {
    return currentUser;
  }

  updateUserDialog() async {
    await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text(
          'Update Info',
          style: TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.all(20.0),
        backgroundColor: const Color.fromARGB(255, 0, 173, 181),
        children: [
          const Text(
            'Your profile has updated successfully',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.only(top: 15.0),
            child: TextButton(
              child: const Text(
                'Close.',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (done) {
                  setNull();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  askUserPasswordDialog() async {
    bool passwordVis = true;
    String erorMSG2 = '';
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SimpleDialog(
              title: const Text(
                'Update your Email',
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              contentPadding: const EdgeInsets.all(20.0),
              backgroundColor: const Color.fromARGB(255, 0, 173, 181),
              children: [
                TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () => (passwordVis = !passwordVis),
                          );
                        },
                        icon: passwordVis
                            ? const Icon(
                                Icons.visibility,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              )),
                    label: const Text(
                      'Please provide your password*',
                      style: TextStyle(color: Colors.black),
                    ),
                    hintText: 'Enter Your Password',
                  ),
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText:
                      passwordVis, // user keyboard will have a button to move cursor to next line
                  controller: myController[2],
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(erorMSG2,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.red, fontSize: 15.0)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  child: TextButton(
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      if (myController[2].text.isNotEmpty) {
                        try {
                          await _auth.updateUserEmail(
                              currentUser!.email!,
                              myController[2].text,
                              myController[1].text.trim());
                          if (_auth.getErrorMsg().isNotEmpty) {
                            setState(() {
                              done = false;
                              erorMSG2 = _auth.getErrorMsg().split('] ')[1];
                            });
                          } else {
                            setState(
                              () {
                                done = true;
                              },
                            );
                            await _databaseFeatures
                                .updateUserEmail(myController[1].text.trim());
                            setState(() {
                              currentUser!.email = myController[1].text.trim();
                            });
                            await updateUserDialog();
                            Navigator.of(context).pop();
                          }
                        } catch (e) {
                          erorMSG2 = _auth.getErrorMsg().split('] ')[1];
                        }
                      }
                    },
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  imageContainer() {
    return GestureDetector(
      child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
        const Icon(Icons.edit),
        CircleAvatar(
            backgroundImage: NetworkImage(currentUser!.pictureUrl!),
            maxRadius: 60,
            backgroundColor: Colors.black.withOpacity(0.1)),
      ]),
      onTap: () async {
        await showUpdateImageSheet(context);
      },
    );
  }

  setNull() {
    setState(() {
      setMsgErrorNull();
      setMyControllerNull();
    });
  }
}
