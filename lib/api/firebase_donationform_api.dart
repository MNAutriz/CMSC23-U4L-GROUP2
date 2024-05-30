import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationFormAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // add donation form
  Future<String> addForm(Map<String, dynamic> form) async {
    try{
      await db.collection("donation forms").doc(form['id']).set(form);
      return "Successfully added donation form to Firebase!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllForms() {
    return db.collection("donation forms").snapshots();
  }

  Future<String> deleteForm(String id) async {
    try {
      await db.collection("donation forms").doc(id).delete();

      return "Successfully deleted form";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> updateForm(String id, Map<String, dynamic> updatedForm) async {
    try{
      await db.collection("donation forms").doc(id).update(updatedForm);

      return "Successfully updated form";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getFormById(String id) {
    return db.collection("donation forms").doc(id).get();
  }
}