import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  User? getUser() {
    return auth.currentUser;
  }

  Stream<User?> userSignedIn() {
    return auth.authStateChanges();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        //possible to return something more useful
        //than just print an error message to improve UI/UX
        return e.message;
      } else if (e.code == 'invalid-credential') {
        return e.message;
      } else {
        return "Failed at ${e.code}: ${e.message}";
      }
    }
  }

  //sign in with google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    //Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //sign up method returns string containing errors
  Future<String?> signUp(String email, String password) async {
    UserCredential credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //let's print the object returned by signInWithEmailAndPassword
      //you can use this object to get the user's id, email, etc.\
      print(credential);
      //valid email
      return "";
    } on FirebaseAuthException catch (e) {
      //possible to return something more useful
      //than just print an error message to improve UI/UX

      //if the email is already in use, return the error message
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return ('The account already exists for that email.');
      }

      //if the email is invalid, return the error message
      if (e.code == 'invalid-email') {
        print('Please enter a valid email');
        return ('Please enter a valid email');
      }

      return e.message;
    }
  }

  Future<void> signOut() async {
    if (GoogleSignIn().currentUser != null) {
      await GoogleSignIn().disconnect();
    }

    GoogleSignIn().signOut();

    await auth.signOut();
  }
}
