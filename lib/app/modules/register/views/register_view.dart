import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/utils/custom_button.dart';
import '../../../widgets/utils/custom_textfield.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
              key: controller.registerformKey,
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
                      controller.confirmPasswordController),
                  const SizedBox(height: 50),
                  CustomButton(
                    buttonText: 'Register',
                    routes: Routes.HOME,
                    onPressed: controller.registerUser,
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
    validateFunc: (value){
      if (value!.isEmpty) {
        return 'Name is required';
      }
      return null;
    }
  );
}

//onSaved: (value) {
//  controller.email=value!
//},
// validator: (value) {
//   return controller.validateEmail(value!);
// }

Widget _emailTextField(TextEditingController controller) {
  return CustomTextFormField(
    textEditingController: controller,
    labelText: 'Email',
    hintText: 'Enter Email',
    obscureText: false,
    // TAM ADD
    validateFunc: (value){
      if (value!.isEmpty) {
        return 'Email is required';
      }
      return null;
    }
  );
}

Widget _passwordTextField(TextEditingController controller) {
  return CustomTextFormField(
    textEditingController: controller,
    labelText: 'Password',
    hintText: 'Enter Password',
    obscureText: true,
    // TAM ADD
    validateFunc: (value){
      if (value!.isEmpty) {
        return 'Password is required';
      }
      return null;
    }
  );
}

Widget _confirmPasswordTextField(TextEditingController controller) {
  return CustomTextFormField(
    textEditingController: controller,
    labelText: 'Confirm Password',
    hintText: 'Enter Confirm Password',
    obscureText: true,
    validateFunc: (value){
      if (value!.isEmpty) {
        return 'Confirm Password is required to match the Password';
      }
      return null;
    }
  );
}
