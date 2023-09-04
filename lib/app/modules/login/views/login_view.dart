import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/widgets/utils/my_textfield.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Form(
            key: Get.find<LoginController>().formKey,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // email textfield
                    MyTextField(
                      controller: Get.find<LoginController>().emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // password textfield
                    MyTextField(
                      controller:
                          Get.find<LoginController>().passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),

                    const SizedBox(height: 25),

                    // register in button
                    ElevatedButton(
                      onPressed: () {
                        Get.find<LoginController>()
                            .login(); // Call the registerUser method
                      },

                      child: const Text('Login'), // Button text
                    ),

                    const SizedBox(height: 25),

                    // Login button
                    TextButton(
                        onPressed: () {
                          Get.offAllNamed('/register');
                        },
                        child: const Text('Register')),

                    const SizedBox(height: 25),

                    // Login button
                    TextButton(
                        onPressed: () {
                          Get.offAllNamed('/dashboard');
                        },
                        child: const Text('Dashboard')),

                    const SizedBox(height: 50),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
