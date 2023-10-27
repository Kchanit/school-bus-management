class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String? citizenId;
  final String? imageUrl;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    this.citizenId,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      role: json['role'],
      citizenId: json['citizen_id'],
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
    };
  }

  get fullName => '$firstName $lastName';
}
