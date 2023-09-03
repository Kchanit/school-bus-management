import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_bus/api_service.dart';
import 'package:school_bus/components/my_button.dart';
import 'package:school_bus/components/my_textfield.dart';
import 'package:school_bus/models/user_model.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  _register() async {
    try {
      final user = User(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      var res = await ApiService().postData(user.toJson(), '/register');
      if (res['success']) {
        print('Registration successful');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
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
                controller: nameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                // onTap: registerUser,
                onTap: _register,
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
