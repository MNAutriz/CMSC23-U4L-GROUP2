import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  //add donor with user uid
  Future<String> addDonor(Map<String, dynamic> donor) async {
    try {
      await db.collection("donors").doc(donor['id']).set(donor);

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

  // update donor 
  // Future<String> updateDonor(String id, Map<String, dynamic> updatedFields) async {
  //   try {
  //     await db.collection("donors").doc(id).update(updatedFields);
  //     return "Successfully updated donor!";
  //   } on FirebaseException catch (e) {
  //     return "Error in ${e.code}: ${e.message}";
  //   }
  // }

  //fetch the collection of donors
  CollectionReference<Map<String, dynamic>> getDonorCollection() {
    return db.collection("donors");
  }
}
