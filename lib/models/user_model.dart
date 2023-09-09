class User {
  final int id;
  final String name;
  final String email;
  final String role;
  String? imagePath;
  String? address;
  double? home_latitude;
  double? home_longitude;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.imagePath,
    this.address,
    this.home_latitude,
    this.home_longitude,
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
      imagePath: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'image': imagePath,
      'address': address,
      'home_latitude': home_latitude,
      'home_longitude': home_longitude,
    };
  }
}
