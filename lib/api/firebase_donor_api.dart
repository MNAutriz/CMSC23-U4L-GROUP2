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

  //fetch the collection of donors
  CollectionReference<Map<String, dynamic>> getDonorCollection() {
    return db.collection("donors");
  }

  // // fetch donor address
  // Future<String?> getDonorAddress(String id) async {
  //   try {
  //     DocumentSnapshot<Map<String, dynamic>> donorSnapshot =
  //         await db.collection("donors").doc(id).get();

  //     if (donorSnapshot.exists) {
  //       // Check if the address field exists in the donor document
  //       if (donorSnapshot.data()!.containsKey('address')) {
  //         // Return the address field value
  //         return donorSnapshot.data()!['address'] as String?;
  //       } else {
  //         return "Address field does not exist for this donor.";
  //       }
  //     } else {
  //       return "Donor with ID $id does not exist.";
  //     }
  //   } on FirebaseException catch (e) {
  //     // Handle Firebase exceptions
  //     return "Error in ${e.code}: ${e.message}";
  //   }
  // }
}
