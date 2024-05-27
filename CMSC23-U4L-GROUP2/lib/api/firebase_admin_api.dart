import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAdminAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  //fetch the collection of admins
  CollectionReference<Map<String, dynamic>> getAllAdmins() {
    return db.collection("admins");
  }
}
