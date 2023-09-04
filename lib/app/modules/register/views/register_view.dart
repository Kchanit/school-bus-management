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
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
            const SizedBox(height: 50),
            _nameTextField(nameController),
            const SizedBox(height: 25),
            _emailTextField(emailController),
            const SizedBox(height: 25),
            _passwordTextField(passwordController),
            const SizedBox(height: 25),
            _confirmPasswordTextField(confirmPasswordController),
            const SizedBox(height: 50),
            const CustomButton(
              buttonText: 'Register',
              routes: Routes.HOME,
            )
          ],
        )),
      ),
    );
  }
}

Widget _nameTextField(TextEditingController textEditingController) {
  return CustomTextFormField(
    textEditingController: textEditingController,
    labelText: 'Name',
    hintText: 'Enter Name',
  );
}

Widget _emailTextField(TextEditingController textEditingController) {
  return CustomTextFormField(
    textEditingController: textEditingController,
    labelText: 'Email',
    hintText: 'Enter Email',
  );
}

Widget _passwordTextField(TextEditingController textEditingController) {
  return CustomTextFormField(
    textEditingController: textEditingController,
    labelText: 'Password',
    hintText: 'Enter Password',
  );
}

Widget _confirmPasswordTextField(TextEditingController textEditingController) {
  return CustomTextFormField(
    textEditingController: textEditingController,
    labelText: 'Confirm Password',
    hintText: 'Enter Confirm Password',
  );
}
