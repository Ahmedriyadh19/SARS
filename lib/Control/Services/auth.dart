import 'package:firebase_auth/firebase_auth.dart' as firebase;

import 'package:sars/Model/user.dart';

class AuthUserMethod {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;

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

// Sign with google

// Sign with facebook

// Registration
  Future registrationUserAuth(User userInput) async {
    try {
      firebase.UserCredential resultAuth =
          await _auth.createUserWithEmailAndPassword(
              email: userInput.email!, password: userInput.password!);
      firebase.User userFromAuth = resultAuth.user as firebase.User;
      return _userFromFirebase(userFromAuth);
    } catch (e) {
      return (e.toString());
    }
  }

// sign out
  Future signOutUser() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
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