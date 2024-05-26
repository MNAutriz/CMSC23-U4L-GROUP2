import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUsernameAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  //add username with email to database
  Future<String> addUsername(Map<String, dynamic> user) async {
    try {
      await db.collection("usernames").doc(user['id']).set(user);

      return "Successfully saved username and email";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  //get all usernames
  Stream<QuerySnapshot> getAllUsernames() {
    return db.collection("usernames").snapshots();
  }

  //delete donor
  Future<String> deleteUsername(String id) async {
    try {
      await db.collection("usernames").doc(id).delete();

      return "Successfully deleted username and email!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  //fetch the collection of usernames
  CollectionReference<Map<String, dynamic>> getUsernameCollection() {
    return db.collection("usernames");
  }
}
