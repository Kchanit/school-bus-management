import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/app/services/auth_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/models/student_model.dart';
import 'package:school_bus/models/user_model.dart';

class UserController extends GetxController {
  Rx<User?> currentUser = Rx<User?>(null);
  Rx<User?> myDriver = Rx<User?>(null);
  final apiService = ApiService();
  final studentController = Get.find<StudentController>();
  final userId = AuthService().getId;

  void setCurrentUser(User user) {
    currentUser.value = user;
  }

  //Get Parent
  Future<void> fetchParent(id) async {
    final response = await apiService.getData('/users/$id');
    if (response['success'] == true) {
      final User parent = User.fromJson(response['user']);
      currentUser.value = parent;
    } else {
      Get.snackbar('Error', response['message']);
    }
  }

  // Parent get students
  Future<void> fetchStudent(id) async {
    final response = await apiService.getData('/students/$id/get-my-students');
    if (response['success'] == true) {
      final List<Student> studentsData = (response['students'] as List)
          .map((student) => Student.fromJson(student))
          .toList();
      print("Students Amount: ${studentsData.length}");
      studentController.myStudents.assignAll(studentsData);
      if (studentController.myStudents.isNotEmpty) {
        studentController.student.value = studentController.myStudents[0];
        print("Student: ${studentController.student.value!.fullName} ");
      } else {
        print("No students");
      }
    } else {
      Get.snackbar('Error', response['message']);
    }
  }

  // Parent get driver
  Future<void> fetchMyDriver(studentId) async {
    var response = await apiService.getData('/drivers/$studentId/get-driver');
    if (response['success'] == true) {
      myDriver.value = User.fromJson(response['driver']);
      // Get the driver image
      // myDriver.value!.imageUrl = response['image_url'];
    } else {
      // Get.snackbar('Error', response['message']);
      print(response['message']);
    }
  }

  // Driver get students
  Future<void> fetchRoute(id) async {
    final response = await apiService.getData('/routes/$id/get-my-route');
    if (response['success'] == true) {
      final List<Student> students = (response['students'] as List)
          .map((student) => Student.fromJson(student))
          .toList();

      if (students.isNotEmpty) {
        students.sort((a, b) => a.order!.compareTo(b.order!));
        studentController.myStudents.assignAll(students);
        for (var i = 0; i < studentController.myStudents.length; i++) {
          print(studentController.myStudents[i].fullName);
          print(studentController.myStudents[i].order);
        }
        print("Students Amount: ${studentController.myStudents.length}");
      } else {
        print("No students");
      }
    }
  }

  // Driver get route address
  fetchRouteAddress(id) async {
    final response = await apiService.getData('/routes/$id/get-route-address');
    if (response['success'] == true) {
      final List<dynamic> routeAddressData = response['addresses'];

      // Create a map of order-to-address, assuming order is unique
      final Map<int, Map<String, dynamic>> routeAddresses = {};
      for (var i = 0; i < routeAddressData.length; i++) {
        routeAddresses[i] = {
          'address': routeAddressData[i]['home_address'].toString(),
          'latitude': routeAddressData[i]['home_latitude'],
          'longitude': routeAddressData[i]['home_longitude'],
        };
      }

      for (var i = 0; i < studentController.myStudents.length; i++) {
        studentController.myStudents[i].address = routeAddresses[i]!['address'];
        studentController.myStudents[i].homeLatitude =
            double.tryParse(routeAddresses[i]!['latitude']);
        studentController.myStudents[i].homeLongitude =
            double.tryParse(routeAddresses[i]!['longitude']);
      }
    }
  }

  Future getDriverImageUrl(id) async {
    print("Get driver image url");
    print(id);
    var response = await ApiService().getData('/drivers/$id/get-image');
    if (response['success'] == true) {
      var imageUrl = response['image_url'];
      print(imageUrl);
      return imageUrl;
    }
    print("No image");
    return null;
  }
}
