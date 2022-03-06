import 'package:flutter/material.dart';
import 'package:sars/Control/Services/auth.dart';
import 'package:sars/Model/user.dart';
import 'package:sars/View/BuildWidgetsData/loading.dart';

class RegistrationBuild extends StatefulWidget {
  const RegistrationBuild({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => Registration();
}

class Registration extends State {
  final AuthUserMethod _auth = AuthUserMethod();
  static String errorMsg = '';
  bool passwordVis = true;
  bool passwordVis2 = true;
  static bool checker = true;
  bool loading = false;

  static List<String?> erorrTexts = List.generate(6, (i) => null);
  static final List<TextEditingController> myController =
      List.generate(6, (i) => TextEditingController());

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

  setVisibility() {
    setState(() {
      passwordVis = !passwordVis;
    });
  }

  setVisibility2() {
    setState(() {
      passwordVis2 = !passwordVis2;
    });
  }

  checkValidator() async {
    checker = true;
    setState(() {
      setMsgErrorNull();
      if (myController[0].text.isEmpty) {
        erorrTexts[0] = 'User Name is required';
        checker = false;
      }
      if (myController[1].text.isEmpty) {
        erorrTexts[1] = 'Email is required';
        checker = false;
      }

      if (myController[2].text.isEmpty) {
        erorrTexts[2] = 'Password is required';
        checker = false;
      }
      if (myController[2].text.length < 6) {
        erorrTexts[2] = 'Password should be at least 6 characters';
        checker = false;
      }
      if (myController[3].text.isEmpty) {
        erorrTexts[3] = 'Confirm Password is required';
        checker = false;
      }
      if (myController[2].text != myController[3].text) {
        erorrTexts[3] = 'The password is not much';
        checker = false;
      }
      if (myController[4].text.isEmpty) {
        erorrTexts[4] = 'The phone number is required';
        checker = false;
      }
      if (myController[4].text.length > 14) {
        erorrTexts[4] = 'The phone number is invalid';
        checker = false;
      }
      if (myController[5].text.isEmpty) {
        erorrTexts[5] = 'The address is required';
        checker = false;
      }
    });

    if (checker == true) {
      User user = User(
        name: myController[0].text,
        email: myController[1].text,
        password: myController[2].text,
        phone: myController[4].text,
        address: myController[5].text,
      );

      setState(() {
        loading = true;
      });

      dynamic result = await _auth.registrationUserAuth(user);

      if (result == null) {
        checker = false;
        setState(() {
          loading = false;
          errorMsg = _auth.getErrorMsg();
        });
      } else {
        setMsgErrorNull();
        setMyControllerNull();
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double? newWidth = MediaQuery.of(context).size.width - 50;

    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 20,
              backgroundColor: const Color.fromARGB(255, 0, 173, 181),
              title: Container(
                padding: EdgeInsets.only(left: newWidth - 265),
                child: const Text(
                  'Registration',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 20,
                          color: Colors.white,
                        ),
                        Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 20,
                          color: Colors.white,
                        ),
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            body: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(0, 173, 181, 1),
                    Color.fromRGBO(0, 57, 60, 1),
                  ],
                )),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        width: newWidth,
                        // height: 650,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black.withOpacity(0.1)),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(12),
                                padding: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(
                                        255, 169, 225, 228)),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    icon: const Icon(
                                      Icons.person_rounded,
                                      color: Colors.black,
                                    ),
                                    labelText: 'User Name',
                                    hintText: 'Enter Your User Name',
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    iconColor: Colors.black,
                                    errorText: erorrTexts[0],
                                  ),
                                  keyboardType: TextInputType.name,
                                  controller: myController[0],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(
                                        255, 169, 225, 228)),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      icon: const Icon(
                                        Icons.email_rounded,
                                        color: Colors.black,
                                      ),
                                      labelText: 'Email',
                                      hintText: 'Enter Your Email',
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      iconColor: Colors.black,
                                      errorText: erorrTexts[1]),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: myController[1],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(
                                        255, 169, 225, 228)),
                                child: TextFormField(
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      icon: const Icon(
                                        Icons.lock_rounded,
                                        color: Colors.black,
                                      ),
                                      labelText: "Password",
                                      hintText: 'Password',
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      iconColor: Colors.black,
                                      errorText: erorrTexts[2],
                                      suffixIcon: IconButton(
                                          onPressed: setVisibility,
                                          icon: passwordVis
                                              ? const Icon(
                                                  Icons.visibility,
                                                  color: Colors.black,
                                                )
                                              : const Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.black,
                                                ))),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: passwordVis,
                                  controller: myController[2],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(
                                        255, 169, 225, 228)),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      icon: const Icon(
                                        Icons.lock_rounded,
                                        color: Colors.black,
                                      ),
                                      labelText: "Confirm Password",
                                      hintText: 'Confirm Password',
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      iconColor: Colors.black,
                                      errorText: erorrTexts[3],
                                      suffixIcon: IconButton(
                                          onPressed: setVisibility2,
                                          icon: passwordVis2
                                              ? const Icon(
                                                  Icons.visibility,
                                                  color: Colors.black,
                                                )
                                              : const Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.black,
                                                ))),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: passwordVis2,
                                  controller: myController[3],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(
                                        255, 169, 225, 228)),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    errorText: erorrTexts[4],
                                    icon: const Icon(
                                      Icons.phone_android,
                                      color: Colors.black,
                                    ),
                                    labelText: 'Phone',
                                    hintText: 'Enter Your Phone Number',
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    iconColor: Colors.black,
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: myController[4],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(
                                        255, 169, 225, 228)),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    errorText: erorrTexts[5],
                                    icon: const Icon(
                                      Icons.location_city_rounded,
                                      color: Colors.black,
                                    ),
                                    labelText: 'Address',
                                    hintText: 'Enter Your Address',
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    iconColor: Colors.black,
                                  ),
                                  keyboardType: TextInputType.name,
                                  controller: myController[5],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 50),
                                child: ElevatedButton(
                                    child: const Text('Register'),
                                    style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all(30),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 141, 218, 221)))),
                                        backgroundColor: MaterialStateProperty.all(
                                            const Color.fromARGB(0, 0, 57, 60)),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.only(left: 50, right: 50)),
                                        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 15))),
                                    onPressed: checkValidator),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(errorMsg,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 15.0)),
                              )
                            ],
                          ),
                        )),
                  ),
                )),
          );
  }
}

 /*  doSubmit() {
    if (checkValidator() == false) {
      setState(() {
        loading = false;
        checker = false;
        errorMsg = _auth.getErrorMsg();
      });
      /*  showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: const Text('Registration'),
          contentPadding: const EdgeInsets.all(20.0),
          backgroundColor: const Color.fromARGB(255, 85, 200, 205),
          children: [
            Text(
              msg,
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: TextButton(
                child: const Text(
                  'Close.',
                  style: TextStyle(color: Color.fromARGB(255, 18, 49, 85)),
                ),
                onPressed: () => {Navigator.of(context).pop()},
              ),
            )
          ],
        ),
      ); */
    else
   */

            /* focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          )*/
                                   /* focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          )*/

                             /* focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0)),*/
                                 //focusColor: Colors.amber,
                                      /* focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0)),*/
                              
                                      /* focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          )*/

                                                              /* focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          )*/