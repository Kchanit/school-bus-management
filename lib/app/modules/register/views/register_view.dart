import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/utils/custom_button.dart';
import '../../../widgets/utils/custom_textfield.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

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
                  ElevatedButton(
                      onPressed: () => controller.getImage(),
                      child: const Text('Select Image')),
                  // const SizedBox(height: 25),
                  // Center(
                  //   child: CircleAvatar(
                  //     radius: 40,
                  //     backgroundImage: NetworkImage(
                  //         'https://storage.googleapis.com/download/storage/v1/b/school-bus-bucket/o/85b49bdc-85a5-4d32-a73e-8c6d81b17ef18141413224892747460.jpg?generation=1694613051915343&alt=media'),
                  //   ),
                  // ),
                  const SizedBox(height: 25),
                  _nameTextField(controller.nameController),
                  const SizedBox(height: 25),
                  _emailTextField(controller.emailController),
                  const SizedBox(height: 25),
                  _passwordTextField(controller.passwordController),
                  const SizedBox(height: 25),
                  _confirmPasswordTextField(
                      controller.confirmPasswordController),
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

Widget _nameTextField(TextEditingController controller) {
  return CustomTextFormField(
    textEditingController: controller,
    labelText: 'Name',
    hintText: 'Enter Name',
    obscureText: false,
  );
}

Widget _emailTextField(TextEditingController controller) {
  return CustomTextFormField(
    textEditingController: controller,
    labelText: 'Email',
    hintText: 'Enter Email',
    obscureText: false,
  );
}

Widget _passwordTextField(TextEditingController controller) {
  return CustomTextFormField(
    textEditingController: controller,
    labelText: 'Password',
    hintText: 'Enter Password',
    obscureText: true,
  );
}

Widget _confirmPasswordTextField(TextEditingController controller) {
  return CustomTextFormField(
    textEditingController: controller,
    labelText: 'Confirm Password',
    hintText: 'Enter Confirm Password',
    obscureText: true,
  );
}
