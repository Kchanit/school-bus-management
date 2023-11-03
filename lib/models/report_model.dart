import 'package:school_bus/models/student_model.dart';

class Report {
  final int driverId;
  final List<Student> students;
  final String date;
  final String startTime;
  String? endTime;

  Report({
    required this.driverId,
    required this.students,
    required this.date,
    required this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "driver_id": driverId,
      "date": date,
      "students": students.map((student) => student.toJson()).toList(),
      "start_time": startTime,
      "end_time": endTime,
    };
  }
}
