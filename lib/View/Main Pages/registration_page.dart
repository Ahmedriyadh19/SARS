import 'package:flutter/material.dart';


class RegistrationBuild extends StatefulWidget {
  const RegistrationBuild({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Registration();
}

class Registration extends State {
  bool passwordVis = true;
  bool passwordVis2 = true;
  static List<String?> erorrText = List.generate(6, (i) => null);

  static setMsgErrorNull() {
    for (int i = 0; i < erorrText.length; i++) {
      erorrText[i] = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String msg = 'The registration has done successfully';
    List myController = List.generate(6, (i) => TextEditingController());
    List myFocusNode = List.generate(6, (i) => FocusNode());

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

    bool checkValidator() {
      bool checker = true;
      setState(() {
        if (myController[2].text != myController[3].text) {
          erorrText[3] = 'The password is not much';
          checker = false;
        } else {
          setMsgErrorNull();
        }
      });
      return checker;
    }

    show() {
      if (checkValidator()) {
        showDialog(
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
                  onPressed: () => {
                    Navigator.of(context)
                        .pop() /*pushReplacement(MaterialPageRoute(
                    builder: (_) => const LoginBuilder(),
                  ))*/
                  },
                ),
              )
            ],
          ),
        );
      }
    }

    double? newWidth = MediaQuery.of(context).size.width - 50;

    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: const Color.fromARGB(255, 0, 173, 181),
        title: Container(
           padding:  EdgeInsets.only(left: newWidth-265),
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
                  width: newWidth,
                  height: 600,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Colors.black.withOpacity(0.1)),
                  child: SingleChildScrollView(
                    child: Form(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(12),
                              padding: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 169, 225, 228)),
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
                                  errorText: erorrText[0],
                                  /* focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              )*/
                                ),
                                keyboardType: TextInputType.name,
                                controller: myController[0],
                                focusNode: myFocusNode[0],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 169, 225, 228)),
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
                                    errorText: erorrText[1]

                                    /* focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              )*/
                                    ),
                                keyboardType: TextInputType.emailAddress,
                                controller: myController[1],
                                focusNode: myFocusNode[1],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 169, 225, 228)),
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
                                    //focusColor: Colors.amber,
                                    /* focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0)),*/
                                    errorText: erorrText[2],
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
                                focusNode: myFocusNode[2],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 169, 225, 228)),
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
                                    errorText: erorrText[3],
                                    /* focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0)),*/
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
                                focusNode: myFocusNode[3],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 169, 225, 228)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  errorText: erorrText[4],
                                  icon: const Icon(
                                    Icons.phone_android,
                                    color: Colors.black,
                                  ),
                                  labelText: 'Phone',
                                  hintText: 'Enter Your Phone Number',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  iconColor: Colors.black,
                                  /* focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              )*/
                                ),
                                keyboardType: TextInputType.number,
                                controller: myController[4],
                                focusNode: myFocusNode[4],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 169, 225, 228)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  errorText: erorrText[5],
                                  icon: const Icon(
                                    Icons.location_city_rounded,
                                    color: Colors.black,
                                  ),
                                  labelText: 'Address',
                                  hintText: 'Enter Your Address',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  iconColor: Colors.black,
                                  /* focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              )*/
                                ),
                                keyboardType: TextInputType.name,
                                controller: myController[5],
                                focusNode: myFocusNode[5],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: ElevatedButton(
                                  child: const Text('Register'),
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(30),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
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
                                  onPressed: show),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          )),
    );
  }
}
