import 'package:firebase_auth/firebase_auth.dart';

class FirebaseCustoms {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static User initAuth() {
    User toReturnUser;
    _auth.authStateChanges().listen((User user) {
      if (user != null) {
        print("${user.email} logged in.");
        toReturnUser = user;
      } else
        print('No user logged in.');
    });
    return toReturnUser;
  }

  static Future<int> requestRegistration(String email, String password) async {
    ///   [toReturnRegistration]
    ///
    ///   0    =>   Registration Unprocessed (Local Error).
    ///   0    =>   Invalid Email Id Format..
    int toReturnRegistration = 0;

    try {
      // UserCredential registeredUserCredentials =
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      /// [toReturnRegistration] == 1  =>    Registration Successful.
      toReturnRegistration = 1;
      print('User Registered');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        /// [toReturnRegistration] == -1  =>    Weak Password.
        toReturnRegistration = -1;
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        /// [toReturnRegistration] == -2  =>    Email already in use.
        toReturnRegistration = -2;
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return toReturnRegistration;
  }

  static Future<int> logIn(String email, String password) async {
    ///   [toReturnLogin]
    ///
    ///   0    =>   Registration Unprocessed (Local Error).
    ///        =>   Invalid Email Id Format.
    int toReturnLogin = 0;

    try {
      // UserCredential loggedInUserCredentials =
      await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      /// [toReturnLogin] == 1  =>    Registration Successful.
      toReturnLogin = 1;
      print('User Logged In');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        /// [toReturnLogin] == -1  =>    'user-not-found'.
        toReturnLogin = -1;
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        /// [toReturnLogin] == -2  =>    wrong-password.
        toReturnLogin = -2;
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }

    return toReturnLogin;
  }

  static Future<bool> logOut() async {
    bool toReturnLogOut = false;

    try {
      _auth.signOut();
      print('Logged Out');
      toReturnLogOut = true;
    } catch (e) {
      print(e);
    }

    return toReturnLogOut;
  }
}
