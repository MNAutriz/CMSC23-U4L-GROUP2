import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // add donation drive to donation_drives collection
  Future<String> addDonationDrive(Map<String, dynamic> drive) async {
    try{
      await db.collection("donation_drives").add(drive);
      return "Successfully added donation drive";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  // return stream of all donationdrives
  Stream<QuerySnapshot> getAllDonationDrives() {
    return db.collection('donation_drives').snapshots();
  }

  // delete donation drive in donation_drives collection
  Future<String> deleteDonationDrive(String id) async {
    try{
      await db.collection("donation_drives").doc(id).delete();
      return "Successfully deleted donation drive";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  // replace donation drive with updatedDrive
  Future<String> editDonationDrive(String id, Map<String, dynamic> updatedDrive) async {
    try {
      await db.collection("donation_drives").doc(id).update(updatedDrive);
      return "Successfully updated donation drive";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}