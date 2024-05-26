import 'dart:convert';

class Username {
  String? id;
  String email;
  String username;

  Username({
    this.id,
    required this.email,
    required this.username,
  });

  // Factory constructor to instantiate object from json format
  factory Username.fromJson(Map<String, dynamic> json) {
    return Username(
        id: json['id'], email: json['email'], username: json['username']);
  }

  static List<Username> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Username>((dynamic d) => Username.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Username username) {
    return {
      'id': username.id,
      'email': username.email,
      'username': username.username,
    };
  }
}
