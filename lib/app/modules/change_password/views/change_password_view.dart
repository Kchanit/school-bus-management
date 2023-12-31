import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/utils/custom_textfield.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  ChangePasswordView({Key? key}) : super(key: key);
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Password',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            CupertinoButton(
                child: const Text(
                  'Done',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  controller.saveData();
                })
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Change your password',
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextFormField(
                  textEditingController: controller.passwordController,
                  labelText: 'Old password',
                  autofocus: true,
                  obscureText: false),
              const SizedBox(
                height: 25,
              ),
              CustomTextFormField(
                  textEditingController: controller.newPasswordController,
                  labelText: 'New password',
                  autofocus: true,
                  obscureText: false),
              const SizedBox(
                height: 25,
              ),
              CustomTextFormField(
                  textEditingController: controller.confirmPasswordController,
                  labelText: 'Confirm new password',
                  autofocus: true,
                  obscureText: false),
              const SizedBox(
                height: 25,
              ),
              Obx(() => Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  )),
            ],
          ),
        ));
  }
}
