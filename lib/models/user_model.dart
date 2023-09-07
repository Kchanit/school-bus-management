class User {
  final int id;
  final String name;
  final String email;
  final String role;
  double? home_latitude;
  double? home_longitude;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.home_latitude,
    this.home_longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      home_latitude: double.parse(json['home_latitude']),
      home_longitude: double.parse(json['home_longitude']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'home_latitude': home_latitude,
      'home_longitude': home_longitude,
    };
  }
}
