import 'package:get/get.dart';
import 'package:school_bus/app/modules/register/controllers/register_controller.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/student_model.dart';

class SelectStudentController extends GetxController {
  // User currentUser = Get.find<UserController>().currentUser.value!;
  RxList<Student> myStudents = <Student>[].obs;
  RxList<Student> selectedStudents = <Student>[].obs;
  
  List<Student> tmpSelectedStudents = <Student>[
    Student(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        imageUrl:
            'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
    Student(
      id: 2,
      firstName: 'Jane',
      lastName: 'Doe',
      // imageUrl:
      // 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
    ),
  ];

  @override
  void onInit() async {
    super.onInit();
    var data = {
      "citizen_id": Get.find<RegisterController>().citizenIdController.text,
    };

    var response = await ApiService().postData(data, '/students/my-students');
    if (response['success'] == true) {
      List<dynamic> studentJsonList = response['students'];
      List<Student> studentList = studentJsonList
          .map((studentJson) => Student.fromJson(studentJson))
          .toList();
      myStudents.assignAll(studentList);
    } else {
      Get.snackbar('Error', 'Cannot get student data');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
