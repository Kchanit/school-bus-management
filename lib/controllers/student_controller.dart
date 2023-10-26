import 'package:get/get.dart';
import 'package:school_bus/models/student_model.dart';

class StudentController extends GetxController {
  Set<Rx<Student?>> myStudent = <Rx<Student?>>{};

  void setMyStudent(Student student) {
    myStudent.add(Rx<Student?>(student));
  }
}