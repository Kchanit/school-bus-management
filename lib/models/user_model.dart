class User {
  final int id;
  final String name;
  final String email;
  final String role;
  String? address;
  double? home_latitude;
  double? home_longitude;
  String? fbtoken;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.address,
    this.home_latitude,
    this.home_longitude,
    this.fbtoken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      address: json['address'],
      home_latitude: json['home_latitude'] != null
          ? double.parse(json['home_latitude'].toString())
          : null,
      home_longitude: json['home_longitude'] != null
          ? double.parse(json['home_longitude'].toString())
          : null,
      fbtoken: json['fbtoken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'address': address,
      'home_latitude': home_latitude,
      'home_longitude': home_longitude,
      'fbtoken' : fbtoken,
    };
  }
}
