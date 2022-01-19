import 'package:flutter/material.dart';

class RegistrationBuild extends StatefulWidget {
  const RegistrationBuild({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Registration();
}

class Registration extends State {
  bool passwordVis = true;
  bool passwordVis2 = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: const Color.fromARGB(255, 0, 173, 181),
        title: Container(
          padding: const EdgeInsets.only(left: 70),
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
                  width: 350,
                  height: 600,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Colors.black.withOpacity(0.1)),
                  child: SingleChildScrollView(
                    child: Column(
                      //padding: const EdgeInsets.only(top: 50),
                      children: [
                        Container(
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 169, 225, 228)),
                          child: const TextField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_rounded,
                                color: Colors.black,
                              ),
                              labelText: 'User Name',
                              hintText: 'Enter Your User Name',
                              labelStyle: TextStyle(color: Colors.black),
                              iconColor: Colors.black,
                              /* focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              )*/
                            ),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 169, 225, 228)),
                          child: const TextField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.email_rounded,
                                color: Colors.black,
                              ),
                              labelText: 'Email',
                              hintText: 'Enter Your Email',
                              labelStyle: TextStyle(color: Colors.black),
                              iconColor: Colors.black,
                              /* focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              )*/
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 169, 225, 228)),
                          child: TextField(
                            decoration: InputDecoration(
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
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 169, 225, 228)),
                          child: TextField(
                            decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.lock_rounded,
                                  color: Colors.black,
                                ),
                                labelText: "Confirm Password",
                                hintText: 'Confirm Password',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                iconColor: Colors.black,
                              
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
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 169, 225, 228)),
                          child: const TextField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.phone_android,
                                color: Colors.black,
                              ),
                              labelText: 'Phone',
                              hintText: 'Enter Your Phone Number',
                              labelStyle: TextStyle(color: Colors.black),
                              iconColor: Colors.black,
                              /* focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              )*/
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 169, 225, 228)),
                          child: const TextField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.location_city_rounded,
                                color: Colors.black,
                              ),
                              labelText: 'Address',
                              hintText: 'Enter Your Address',
                              labelStyle: TextStyle(color: Colors.black),
                              iconColor: Colors.black,
                              /* focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              )*/
                            ),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: ElevatedButton(
                            child: const Text('Register'),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(30),
                                shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 15))),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          )),
    );
  }
}
