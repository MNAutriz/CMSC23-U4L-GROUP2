import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  //add donor
  Future<String> addDonor(Map<String, dynamic> donor) async {
    try {
      await db.collection("donors").add(donor);

      return "Successfully registered donor!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  //get all donors
  Stream<QuerySnapshot> getAllDonors() {
    return db.collection("donors").snapshots();
  }

  //delete donor
  Future<String> deleteDonor(String id) async {
    try {
      await db.collection("donors").doc(id).delete();

      return "Successfully deleted donor!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  //fetch the collection of donors
  CollectionReference<Map<String, dynamic>> getDonorCollection() {
    return db.collection("donors");
  }
}
