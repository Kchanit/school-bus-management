import 'package:get/get.dart';

import '../modules/change_status/bindings/change_status_binding.dart';
import '../modules/change_status/views/change_status_view.dart';
import '../modules/check/bindings/check_binding.dart';
import '../modules/check/views/check_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/initial/bindings/initial_binding.dart';
import '../modules/initial/views/initial_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/pick_address/bindings/pick_address_binding.dart';
import '../modules/pick_address/views/pick_address_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/register_address/bindings/register_address_binding.dart';
import '../modules/register_address/views/register_address_view.dart';
import '../modules/register_student/bindings/register_student_binding.dart';
import '../modules/register_student/views/register_student_view.dart';
import '../modules/reorder_student/bindings/reorder_student_binding.dart';
import '../modules/reorder_student/views/reorder_student_view.dart';
import '../modules/select_student/bindings/select_student_binding.dart';
import '../modules/select_student/views/select_student_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/test/bindings/test_binding.dart';
import '../modules/test/views/test_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.INITIAL,
      page: () => const InitialView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: _Paths.TEST,
      page: () => const TestView(),
      binding: TestBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_ADDRESS,
      page: () => const RegisterAddressView(),
      binding: RegisterAddressBinding(),
    ),
    GetPage(
      name: _Paths.PICK_ADDRESS,
      page: () => const PickAddressView(),
      binding: PickAddressBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_STUDENT,
      page: () => const RegisterStudentView(),
      binding: RegisterStudentBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_STUDENT,
      page: () => const SelectStudentView(),
      binding: SelectStudentBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_STATUS,
      page: () => const ChangeStatusView(),
      binding: ChangeStatusBinding(),
    ),
    GetPage(
      name: _Paths.REORDER_STUDENT,
      page: () => const ReorderStudentView(),
      binding: ReorderStudentBinding(),
    ),
    GetPage(
      name: _Paths.CHECK,
      page: () => CheckView(),
      binding: CheckBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => const MapView(),
      binding: MapBinding(),
    ),
  ];
}
