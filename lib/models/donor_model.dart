import 'dart:convert';

class Donor {
  String? id;
  String email;
  String username;
  String name;
  List<dynamic> address;
  String contact;

  Donor(
      {this.id,
      required this.email,
      required this.username,
      required this.name,
      required this.address,
      required this.contact});

  // Factory constructor to instantiate object from json format
  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        name: json['name'],
        address: json['address'],
        contact: json['contact']);
  }

  static List<Donor> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donor>((dynamic d) => Donor.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donor donor) {
    return {
      'id': donor.id,
      'email': donor.email,
      'username': donor.username,
      'name': donor.name,
      'address': donor.address,
      'contact': donor.contact
    };
  }
}
