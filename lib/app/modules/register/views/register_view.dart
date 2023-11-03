import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/styles/space.dart';

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
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/arrow-left.svg'),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register 👋',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Space.sm,
                  const Text(
                    'Please, fill your information.',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Form(
                key: controller.formKey,
                child: Center(
                  child: Column(
                    children: [
                      Space.md,
                      _firstNameTextField(controller.firstNameController),
                      Space.md,
                      _lastNameTextField(controller.lastNameController),
                      Space.md,
                      _emailTextField(controller.emailController),
                      if (controller.emailError.value != '')
                        Column(
                          children: [
                            Space.xs,
                            Text(
                              controller.emailError.value,
                              style: TextStyle(
                                  color: Colors.red[700], fontSize: 12),
                            ),
                          ],
                        ),
                      Space.md,
                      _citizenIdTextField(controller.citizenIdController),
                      if (controller.citizenIdError.value != '')
                        Column(
                          children: [
                            Space.xs,
                            Text(
                              controller.citizenIdError.value,
                              style: TextStyle(
                                  color: Colors.red[700], fontSize: 12),
                            ),
                          ],
                        ),
                      Space.md,
                      _passwordTextField(controller.passwordController),
                      Space.md,
                      _confirmPasswordTextField(
                          controller.confirmPasswordController,
                          controller.passwordController),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                buttonText: 'Next',
                routes: Routes.HOME,
                onPressed: () => controller.goNext(),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

Widget _firstNameTextField(TextEditingController controller) {
  return CustomTextFormField(
      textEditingController: controller,
      labelText: 'First Name',
      hintText: 'Enter your first name',
      obscureText: false,
      validateFunc: (value) {
        if (value!.isEmpty) {
          return 'First name is required';
        }
        return null;
      });
}

Widget _lastNameTextField(TextEditingController controller) {
  return CustomTextFormField(
      textEditingController: controller,
      labelText: 'Last Name',
      hintText: 'Enter your last name',
      obscureText: false,
      validateFunc: (value) {
        if (value!.isEmpty) {
          return 'Last name is required';
        }
        return null;
      });
}

Widget _citizenIdTextField(TextEditingController controller) {
  return CustomTextFormField(
      textEditingController: controller,
      labelText: 'Citizen ID',
      hintText: 'Enter your citizen ID',
      keyboardType: TextInputType.number,
      obscureText: false,
      validateFunc: (value) {
        if (value!.isEmpty) {
          return 'Citizen ID is required';
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

Widget _confirmPasswordTextField(
    TextEditingController controller, passwordController) {
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
