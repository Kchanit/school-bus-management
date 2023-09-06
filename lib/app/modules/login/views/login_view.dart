import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
          Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  _emailTextField(controller.emailController),
                  const SizedBox(height: 25),
                  _passwordTextField(controller.passwordController),
                  const SizedBox(height: 50),
                  CustomButton(
                    buttonText: 'Login',
                    onPressed: controller.login,
                  )
                ],
              )),
        ],
      )),
    );
  }
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
