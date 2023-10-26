class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String citizenId;
  // double? home_latitude;
  // double? home_longitude;
  String? imageUrl;
  String? fbtoken;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.citizenId,
    // this.home_latitude,
    // this.home_longitude,
    this.imageUrl,
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
      // address: json['address'],
      // home_latitude: json['home_latitude'] != null
      //     ? double.parse(json['home_latitude'].toString())
      //     : null,
      // home_longitude: json['home_longitude'] != null
      //     ? double.parse(json['home_longitude'].toString())
      //     : null,
      // imageUrl: json['image_url'],
      fbtoken: json['fbtoken'],
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
      'fbtoken' : fbtoken,
    };
  }
}