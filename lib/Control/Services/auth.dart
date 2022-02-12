import 'package:firebase_auth/firebase_auth.dart' as firebase;

import 'package:sars/Model/user.dart';

class AuthUserMethod {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
  static String errorMsg = '';

  // create user oject based on fairbase user
  User? _userFromFirebase(user) {
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
            name: 'unknow',
            address: 'unknow',
            password: 'unknow',
            role: 'unknow',
            phone: user.phoneNumber,
            pictureUrl: 'unknow')
        : null;
  }

  // auth change user stream

  Stream<User?> get getUserAuth {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

// Lgin Email & Password

  Future loginUserEmailPass(String e, String p) async {
    errorMsg = '';
    try {
      firebase.UserCredential resultAuth =
          await _auth.signInWithEmailAndPassword(email: e, password: p);
      firebase.User userEmailAndPassFromAuth = resultAuth.user as firebase.User;
      return _userFromFirebase(userEmailAndPassFromAuth);
    } catch (e) {
      errorMsg = e.toString().split('] ')[1];
      return null;
    }
  }

// forget Password

  Future userForgetPasswor(String e) async {
    errorMsg = '';
    try {
      return await _auth.sendPasswordResetEmail(email: e);
    } catch (e) {
      errorMsg = e.toString().split('] ')[1];
      print(errorMsg);
      return null;
    }
  }


// Registration

  Future registrationUserAuth(User userInput) async {
    errorMsg = '';
    try {
      firebase.UserCredential resultAuth =
          await _auth.createUserWithEmailAndPassword(
              email: userInput.email!, password: userInput.password!);
      firebase.User userFromAuth = resultAuth.user as firebase.User;
      return _userFromFirebase(userFromAuth);
    } catch (e) {
      errorMsg = e.toString().split('] ')[1];
      return null;
    }
  }

// sign out
  Future signOutUser() async {
    errorMsg = '';
    try {
      return await _auth.signOut();
    } catch (e) {
      errorMsg = e.toString();
      return null;
    }
  }

  //Get the errors based on firebase.
  String getErrorMsg() {
    return errorMsg;
  }

  
// Sign with google

// Sign with facebook


}



// anon

/*   Future anonUser() async {
    try {
      firebase.UserCredential result = await _auth.signInAnonymously();
      firebase.User userFromAuth = result.user as firebase.User;
      return _userFromFirebase(userFromAuth);
    } catch (e) {
      return null;
    }
  } */