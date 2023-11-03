import 'package:get/get.dart';

enum StudentStatus {
  NONE,
  NOT_CHECKED,
  CHECKED, // arrived at bus
  ON_THE_WAY, // on the way
  ARRIVED_AT_HOME, // arrived at home
}

class Student {
  final int id;
  final String firstName;
  final String lastName;
  // final String studentNumber;
  String? address;
  double? homeLatitude;
  double? homeLongitude;
  String? imageUrl;
  Rx<StudentStatus> status;
  int? order;
  bool isTakingBus;
  String? endTime;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.address,
    this.homeLatitude,
    this.homeLongitude,
    this.imageUrl,
    required this.status,
    this.order,
    required this.isTakingBus,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      // studentNumber: json['student_number'],
      address: json['home_address'],
      homeLatitude: json['home_latitude'] != null
          ? double.parse(json['home_latitude'].toString())
          : null,
      homeLongitude: json['home_longitude'] != null
          ? double.parse(json['home_longitude'].toString())
          : null,
      imageUrl: json['image_url'],
      status: _getStatusFromJson(json['status']).obs,
      order: json['order'],
      isTakingBus: json['is_taking_bus'] == 1,
    );
  }
  static StudentStatus _getStatusFromJson(String? status) {
    switch (status) {
      case 'CHECKED':
        return StudentStatus.CHECKED;
      case 'NOT_CHECKED':
        return StudentStatus.NOT_CHECKED;
      default:
        return StudentStatus.NONE;
    }
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
      'status': statusToJson(status.value),
      'order': order,
      'is_taking_bus': isTakingBus,
      'end_time': endTime,
    };
  }

  String statusToJson(StudentStatus status) {
    switch (status) {
      case StudentStatus.CHECKED:
        return 'CHECKED';
      case StudentStatus.NOT_CHECKED:
        return 'NOT_CHECKED';
      default:
        return 'NONE';
    }
  }

  String get statusText {
    switch (status.value) {
      case StudentStatus.CHECKED:
        return 'Checked';
      case StudentStatus.NOT_CHECKED:
        return 'Not Checked';
      default:
        return 'None';
    }
  }

  String get fullName => "$firstName $lastName";
}
