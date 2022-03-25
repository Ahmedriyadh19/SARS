import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:sars/Control/Services/database_services.dart';
import 'package:sars/Model/user.dart';

class AuthUserMethod {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
  String? errorMsg = '';

  // create user oject based on fairbase user
  User? _userFromFirebase(user) {
    return user != null
        ? User(
            uid: user.uid,
          )
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
          await _auth.signInWithEmailAndPassword(email: e.trim(), password: p);
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
      return await _auth.sendPasswordResetEmail(email: e.trim());
    } catch (e) {
      errorMsg = e.toString().split('] ')[1];
      //return null;
    }
  }

// Registration

  Future registrationUserAuth(User userInput) async {
    errorMsg = '';
    try {
      firebase.UserCredential resultAuth =
          await _auth.createUserWithEmailAndPassword(
              email: userInput.email!.trim(), password: userInput.password!);
      firebase.User userFromAuth = resultAuth.user as firebase.User;

      await DatabaseFeatures(uidUser: userFromAuth.uid)
          .createNewUserInfo(userInput);
      return _userFromFirebase(userFromAuth);
    } catch (e) {
      try {
        errorMsg = e.toString().split('] ')[1];
        return null;
      } catch (ee) {
        errorMsg = e.toString();
        return null;
      }
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
    return errorMsg!;
  }

// Sign with google

// Sign with facebook

}
