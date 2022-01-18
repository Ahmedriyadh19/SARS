import 'package:flutter/material.dart';

class LoginPage extends State {
  bool passwordVis;
  Function() switchVisble;
  Function() goToMain;
  Function() goToReg;

  LoginPage({
    required this.passwordVis,
    required this.switchVisble,
    required this.goToMain,
    required this.goToReg,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
             // shrinkWrap: true,
             // padding: const EdgeInsets.only(left: 40, right: 40),
              children: [
            Container(
              alignment: Alignment.center,
              width: 350,
              height: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.black.withOpacity(0.1)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        child: Image.asset(
                      'assets/images/Logo1.png',
                      width: 100,
                      height: 100,
                      filterQuality: FilterQuality.high,
                    )),
                  
                    Text(
                      'Welcome to SARS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      margin: const EdgeInsets.all(12),
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
                            hintText: 'pasword',
                            labelStyle: const TextStyle(color: Colors.black),
                            iconColor: Colors.black,
                            //focusColor: Colors.amber,
                            /* focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0)),*/
                            suffixIcon: IconButton(
                                onPressed: switchVisble,
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
                    const SizedBox(height: 5),
                    const Text(
                      'Forget Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(170, 189, 190, 1)),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text('Login',textAlign: TextAlign.center,),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9.0),
                                      side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 141, 218, 221)))),
                          elevation: MaterialStateProperty.all(30),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(0, 0, 57, 60)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(left: 112, right: 112)),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 15))),
                      onPressed: goToMain,
                    ),
                    //const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Text('Register',textAlign: TextAlign.center,),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(30),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9.0),
                                      side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 141, 218, 221)))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(0, 0, 57, 60)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(left: 103, right: 103)),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 15))),
                      onPressed: goToReg,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(children: const [
              Expanded(
                  child: Divider(
                indent: 60,
                endIndent: 20,
              )),
              Text("Or Sign in!"),
              Expanded(
                  child: Divider(
                indent: 20,
                endIndent: 60,
              )),
            ]),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: 350,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.black.withOpacity(0.1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/icons/icons8_Facebook_48px.png'),
                  Image.asset('assets/icons/icons8_google_48px.png'),
                ],
              ),
            ),
          ])),
    );
  }
}
