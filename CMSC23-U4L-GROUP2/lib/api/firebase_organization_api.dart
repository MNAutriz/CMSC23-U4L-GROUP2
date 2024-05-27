import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrganizationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  //add organization with user uid
  Future<String> addOrganization(Map<String, dynamic> organization) async {
    try {
      await db
          .collection("organizations")
          .doc(organization['id'])
          .set(organization);
      return "Successfully registered organization!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  //get all organizations
  Stream<QuerySnapshot> getAllOrganizations() {
    return db.collection("organizations").snapshots();
  }

  //delete organization
  Future<String> deleteOrganization(String id) async {
    try {
      await db.collection("organizations").doc(id).delete();

      return "Successfully deleted organization!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  //fetch the collection of organizations
  CollectionReference<Map<String, dynamic>> getOrgCollection() {
    return db.collection("organizations");
  }
}
