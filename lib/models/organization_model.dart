import 'dart:convert';

class Organization {
  String? id;
  String email;
  String name;

  Organization({
    this.id,
    required this.email,
    required this.name,
  });

  // Factory constructor to instantiate object from json format
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
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
      'email': organization.email,
      'name': organization.name,
    };
  }
}
