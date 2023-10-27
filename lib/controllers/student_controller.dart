import 'package:get/get.dart';
import 'package:school_bus/models/student_model.dart';

class StudentController extends GetxController {
  Rx<Student?> student = Rx<Student?>(null);
  RxList<Student> myStudents = <Student>[].obs;
}
  // void setMyStudents(List<Student> studentsData) {
  //   for (var student in studentsData) {
  //     myStudents.add(student.obs);
  //   }
  // }
