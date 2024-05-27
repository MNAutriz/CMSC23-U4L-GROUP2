import 'dart:convert';

class Organization {
  String? id;
  String organizationName;
  String email;
  String username;
  String name;
  String address;
  String contact;

  Organization(
      {this.id,
      required this.organizationName,
      required this.email,
      required this.username,
      required this.name,
      required this.address,
      required this.contact});

  // Factory constructor to instantiate object from json format
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
        id: json['id'],
        organizationName: json['organizationName'],
        email: json['email'],
        username: json['username'],
        name: json['name'],
        address: json['address'],
        contact: json['contact']);
  }

  static List<Organization> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<Organization>((dynamic d) => Organization.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson(Organization organization) {
    return {
      'id': organization.id,
      'organizationName': organization.organizationName,
      'email': organization.email,
      'username': organization.username,
      'name': organization.name,
      'address': organization.address,
      'contact': organization.contact
    };
  }
}
