import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/app/widgets/utils/custom_button.dart';
import 'package:school_bus/app/widgets/utils/custom_textfield.dart';

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
          const SizedBox(height: 50),
          _emailTextField(emailController),
          const SizedBox(height: 25),
          _passwordTextField(passwordController),
          const SizedBox(height: 50),
          const CustomButton(
            buttonText: 'Login',
            routes: Routes.HOME,
          )
        ],
      )),
    );
  }
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
