import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/app/styles/space.dart';
import 'package:school_bus/app/widgets/utils/custom_button.dart';
import 'package:school_bus/app/widgets/utils/custom_light_button.dart';
import '../../../styles/stye.dart';
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
        // leading: IconButton(
        //   icon: SvgPicture.asset(
        //     'assets/images/arrow-left.svg',
        //   ),
        //   onPressed: () {
        //     Get.offAndToNamed(Routes.INITIAL);
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 55,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            Space.md,
            Form(
                key: controller.formKey,
                child: Obx(
                  () => SizedBox(
                    width: Style.widthMd(context),
                    child: Column(
                      children: [
                        Space.md,
                        _emailTextField(controller.emailController),
                        Space.md,
                        _passwordTextField(controller.passwordController),
                        if (controller.errorMessage.value != '')
                          Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        Space.lg,
                      ],
                    ),
                  ),
                )),
            CustomButton(
              buttonText: 'Login',
              onPressed: controller.login,
            ),
            Space.md,
            SizedBox(
              width: Style.widthMd(context),
              child: const Row(children: [
                Expanded(child: Divider()),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "or",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: Divider()),
              ]),
            ),
            Space.md,
            CustomLightButton(
              buttonText: 'Register',
              onPressed: () {
                Get.toNamed(Routes.REGISTER);
              },
              routes: Routes.REGISTER,
            ),
          ],
        )),
      ),
    );
  }
}

Widget _emailTextField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter email',
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Style.greyColor)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(8)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(8))),
    obscureText: false,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Email is required';
      }
      if (value.length < 4) {
        return 'Email must be 4 characters or more';
      }
      return null; // Return null if the input is valid
    },
  );
}

Widget _passwordTextField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter Password',
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Style.greyColor),
        ),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(8)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(8))),
    obscureText: true,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Password is required';
      }
      if (value.length < 4) {
        return 'Password must be 4 characters or more';
      }
      return null; // Return null if the input is valid
    },
  );
}
