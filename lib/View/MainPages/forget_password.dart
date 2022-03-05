import 'package:flutter/material.dart';
import 'package:sars/Control/Services/auth.dart';
import 'package:sars/View/MainPages/loading.dart';
import 'package:sars/View/MainPages/login_page.dart';

class ForgetPasswordBuilder extends StatefulWidget {
  const ForgetPasswordBuilder({Key? key}) : super(key: key);

  @override
  State createState() => _ForgetPasswordPage();
}

class _ForgetPasswordPage extends State {
  String? errorForgetPassword;
  String errorMsg = '';
  bool loading = false;
  static bool? chk;
  final AuthUserMethod _auth = AuthUserMethod();
  TextEditingController myControllerForgetPass = TextEditingController();

  checkValidatorForgetPassword() async {
    chk = true;
    dynamic result;
    errorForgetPassword = null;
    errorMsg = '';

    if (myControllerForgetPass.text.isEmpty) {
      setState(() {
        errorForgetPassword = 'Email is required';
        chk = false;
      });
    } else if (myControllerForgetPass.text.isNotEmpty) {
      {
        setState(() {
          loading = true;
        });
        result = await _auth.userForgetPasswor(myControllerForgetPass.text);
        if (result == null) {
          setState(() {
            errorMsg = _auth.getErrorMsg();
            loading = false;
            chk = true;
          });
        }

        if (chk == true && errorMsg.isEmpty) {
          setState(() {
            myControllerForgetPass.clear();
            errorForgetPassword = null;
            errorMsg = '';
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: const Text(
                  'Forget Password',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                contentPadding: const EdgeInsets.all(20.0),
                backgroundColor: const Color.fromARGB(255, 0, 188, 212),
                children: [
                  const Text(
                    'The link has been send to your Email.\nPlease check your email.',
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
                      onPressed: () => {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => const LoginBuilder(),
                        ))
                      },
                    ),
                  )
                ],
              ),
            );
          });
        }
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
              title: const Center(
                child: Text(
                  'Forget password',
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
                                      errorText: errorForgetPassword),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: myControllerForgetPass,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 50),
                                child: ElevatedButton(
                                    child: const Text('Submit'),
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
                                    onPressed: checkValidatorForgetPassword),
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
