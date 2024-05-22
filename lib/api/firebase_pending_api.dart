import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePendingAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  //add pending organization
  Future<String> addPending(Map<String, dynamic> organization) async {
    try {
      await db.collection("pending").add(organization);

      return "Successfully submitted application for organization!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  //get all organizations
  Stream<QuerySnapshot> getAllPending() {
    return db.collection("pending").snapshots();
  }

  //delete organization
  Future<String> deletePending(String id) async {
    try {
      await db.collection("pending").doc(id).delete();

      return "Successfully removed pending organization application!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}
