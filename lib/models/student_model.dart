class Student {
  final int id;
  final String firstName;
  final String lastName;
  // final String studentNumber;
  String? address;
  double? homeLatitude;
  double? homeLongitude;
  String? imageUrl;
  String? status;
  int? order;
  bool isTakingBus = false;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    // required this.studentNumber,
    this.address,
    this.homeLatitude,
    this.homeLongitude,
    this.imageUrl,
    this.status,
    this.order,
    required bool isTakingBus,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      // studentNumber: json['student_number'],
      address: json['address'],
      homeLatitude: json['home_latitude'] != null
          ? double.parse(json['home_latitude'].toString())
          : null,
      homeLongitude: json['home_longitude'] != null
          ? double.parse(json['home_longitude'].toString())
          : null,
      imageUrl: json['image_url'],
      status: json['status'],
      order: json['order'],
      isTakingBus: json['is_taking_bus'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      // 'student_number': studentNumber,
      'address': address,
      'home_latitude': homeLatitude,
      'home_longitude': homeLongitude,
      'image_url': imageUrl,
      'status': status,
      'order': order,
      'is_taking_bus': isTakingBus,
    };
  }

  String get fullName => "$firstName $lastName";
}
