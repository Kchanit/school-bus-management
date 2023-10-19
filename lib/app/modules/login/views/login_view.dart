import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/widgets/utils/custom_button.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 80,
      ),
      body: Center(
          child: Column(
        children: [
          const Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Obx(
                    () => CupertinoSlidingSegmentedControl<String>(
                      groupValue: controller.userRole.value,
                      children: const {
                        'parent': Text('Parent'),
                        'driver': Text('Driver'),
                      },
                      onValueChanged: (value) {
                        print(value);
                        controller.userRole.value = value!;
                        controller.update();
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  _emailTextField(controller.emailController),
                  const SizedBox(height: 25),
                  _passwordTextField(controller.passwordController),
                  const SizedBox(height: 50),
                  CustomButton(
                    buttonText: 'Login',
                    onPressed: controller.login,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/register');
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
                    child: const Text('Register'),
                  ),
                ],
              )),
        ],
      )),
    );
  }
}

Widget _emailTextField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: 'Email',
      hintText: 'Enter email',
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
    obscureText: false,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Email is required';
      }
      if (value.length < 4) {
        return 'Email must be 4 characters or more';
      }
      return null; // Return null if the input is valid
    },
  );
}

Widget _passwordTextField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: 'Password',
      hintText: 'Enter Password',
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
    obscureText: true,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Password is required';
      }
      if (value.length < 4) {
        return 'Password must be 4 characters or more';
      }
      return null; // Return null if the input is valid
    },
  );
}
