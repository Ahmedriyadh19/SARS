import 'package:firebase_auth/firebase_auth.dart';

class AuthUserMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Lgin Email & Password

// Sign with google

// Sign with facebook

// Registration

  Future registrationUser(emailUser, passwordUser) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: emailUser, password: passwordUser);
      var userFromAuth = result.user;
      return userFromAuth;
    } catch (e) {
    //  print(e.toString());
      return null;
    }
  }

// sign out

}
