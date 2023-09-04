import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/widgets/utils/my_textfield.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Form(
            key: Get.find<RegisterController>().formKey,
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

                    // username textfield
                    MyTextField(
                      controller: Get.find<RegisterController>().nameController,
                      hintText: 'Username',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // email textfield
                    MyTextField(
                      controller:
                          Get.find<RegisterController>().emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // password textfield
                    MyTextField(
                      controller:
                          Get.find<RegisterController>().passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),

                    const SizedBox(height: 25),

                    // register in button
                    ElevatedButton(
                      onPressed: () {
                        Get.find<RegisterController>()
                            .registerUser(); // Call the registerUser method
                      },

                      child: const Text('Register'), // Button text
                    ),

                    const SizedBox(height: 25),

                    // Login button
                    TextButton(
                        onPressed: () {
                          Get.offAllNamed('/login');
                        },
                        child: const Text('Login')),

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
