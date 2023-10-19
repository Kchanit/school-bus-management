import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/app/widgets/utils/custom_button.dart';
import 'package:school_bus/app/widgets/utils/custom_textfield.dart';

import '../controllers/register_student_controller.dart';

class RegisterStudentView extends GetView<RegisterStudentController> {
  const RegisterStudentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            const Text(
              'Register',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // Obx(() => CircleAvatar(
                  //       radius: 50,
                  //       backgroundImage: controller.image.value != null
                  //           ? FileImage(controller.image.value!)
                  //           : const AssetImage('assets/images/user.png')
                  //               as ImageProvider,
                  //     )),
                  Obx(
                    () => Center(
                        child: controller.imageBytes.value == null
                            ? const Text('No image selected.')
                            : Stack(
                                children: [
                                  Image.memory(controller.imageBytes.value!),
                                ],
                              )),
                  ),
                  const SizedBox(height: 25),

                  const SizedBox(height: 25),
                  ElevatedButton(
                      onPressed: () => controller.showImageSourceSelection(),
                      child: const Text('Select Image')),

                  const SizedBox(height: 25),
                  _firstNameTextField(controller.firstNameController),
                  const SizedBox(height: 25),
                  _lastNameTextField(controller.lastNameController),

                  const SizedBox(height: 25),
                  _citizenIdTextField(controller.citizenIdController),

                  const SizedBox(height: 50),
                  CustomButton(
                    buttonText: 'Next',
                    routes: Routes.HOME,
                    onPressed: () => controller.goNext(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ))),
                    child: const Text('Login'),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

Widget _firstNameTextField(TextEditingController controller) {
  return CustomTextFormField(
      textEditingController: controller,
      labelText: 'First Name',
      hintText: 'Enter your first name',
      obscureText: false,
      validateFunc: (value) {
        if (value!.isEmpty) {
          return 'First name is required';
        }
        return null;
      });
}

Widget _lastNameTextField(TextEditingController controller) {
  return CustomTextFormField(
      textEditingController: controller,
      labelText: 'Last Name',
      hintText: 'Enter your last name',
      obscureText: false,
      validateFunc: (value) {
        if (value!.isEmpty) {
          return 'Last name is required';
        }
        return null;
      });
}

Widget _citizenIdTextField(TextEditingController controller) {
  return CustomTextFormField(
      textEditingController: controller,
      labelText: 'Citizen ID',
      hintText: 'Enter your citizen ID',
      keyboardType: TextInputType.number,
      obscureText: false,
      validateFunc: (value) {
        if (value!.isEmpty) {
          return 'Citizen ID is required';
        }
        return null;
      });
}

