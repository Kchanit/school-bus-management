import 'package:get/get.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  String imageUrl;
  String? fbtoken;
  final String? citizenId;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    this.citizenId,
    required this.imageUrl,
    this.fbtoken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      role: json['role'],
      citizenId: json['citizen_id'],
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'role': role,
      'citizen_id': citizenId,
      'image_url': imageUrl,
      'fbtoken': fbtoken,
    };
  }

  get fullName => '$firstName $lastName';
}
