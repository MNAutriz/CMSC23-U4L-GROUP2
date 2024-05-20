import 'dart:convert';

class Donor {
  String? id;
  String email;
  String firstName;
  String lastName;

  Donor({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  // Factory constructor to instantiate object from json format
  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  static List<Donor> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donor>((dynamic d) => Donor.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donor donor) {
    return {
      'id': donor.id,
      'email': donor.email,
      'firstName': donor.firstName,
      'lastName': donor.lastName
    };
  }
}
