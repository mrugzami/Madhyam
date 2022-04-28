import 'package:firebase_auth/firebase_auth.dart';

class Authenticator {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> getCurrentFireBaseUser() async {
    var user = _auth.currentUser;
    return user;
  }

  Future<String> getCurrentFireBaseUserID() async {
    try {
      var currentUser = _auth.currentUser;
      String currentUserId = currentUser.uid;
      if (currentUserId == null) {
        return 'NoUserYet';
      } else {
        return currentUser.uid;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Sing in with email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  // Register with email
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getCurrentFireBaseUserEmail() async {
    try {
      User currentUser = _auth.currentUser;
      String currentUserEmail = currentUser.email;
      if (currentUserEmail == null) {
        return 'NoUserYet';
      } else {
        return currentUser.email;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> isUserAuthenticated() async {
    try {
      var currentUser = _auth.currentUser;
      if (currentUser == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      var currentUser = _auth.currentUser;
      currentUser.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  Future sendPasswordReset(String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  // Sing out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
