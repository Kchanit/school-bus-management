import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/utils/custom_button.dart';
import '../../../widgets/utils/custom_textfield.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

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
                  _nameTextField(controller.nameController),
                  const SizedBox(height: 25),
                  _emailTextField(controller.emailController),
                  const SizedBox(height: 25),
                  _passwordTextField(controller.passwordController),
                  const SizedBox(height: 25),
                  _confirmPasswordTextField(
                      controller.confirmPasswordController,controller.passwordController),
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
      validateFunc: (value) {
        if (value!.isEmpty) {
          return 'Name is required';
        }
        return null;
      });
}

Widget _emailTextField(TextEditingController controller) {
  return CustomTextFormField(
      textEditingController: controller,
      labelText: 'Email',
      hintText: 'Enter Email',
      obscureText: false,
      validateFunc: (value) {
        if (value!.isEmpty) {
          return 'Email is required';
        } else if (!GetUtils.isEmail(value)) {
          return "Provide valid Email";
        }
        return null;
      });
}

Widget _passwordTextField(TextEditingController controller) {
  return CustomTextFormField(
      textEditingController: controller,
      labelText: 'Password',
      hintText: 'Enter Password',
      obscureText: true,
      validateFunc: (value) {
        if (value!.isEmpty) {
          return 'Password is required';
        } else if (value.length < 3) {
          return "Password must be of 4 characters or more";
        }
        return null;
      });
}

Widget _confirmPasswordTextField(TextEditingController controller, passwordController) {
  return CustomTextFormField(
      textEditingController: controller,
      labelText: 'Confirm Password',
      hintText: 'Enter Confirm Password',
      obscureText: true,
      validateFunc: (value) {
        if (value!.isEmpty) {
          return 'Confirm Password is required to match the Password';
        } else if (value.length < 3) {
          return "Password must be of 4 characters or more";
        } else if (value != passwordController.text) {
          return "Password is not match";
        }
        return null;
      });
}
