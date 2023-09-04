import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/app/widgets/utils/custom_button.dart';
import 'package:school_bus/app/widgets/utils/custom_light_button.dart';

import '../controllers/initial_controller.dart';

class InitialView extends GetView<InitialController> {
  const InitialView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomLightButton(
            buttonText: 'Login',
            routes: Routes.LOGIN,
          ),
          SizedBox(
            height: 18,
          ),
          CustomButton(
            buttonText: "Register",
            routes: Routes.REGISTER,
          )
        ],
      ),
    ));
  }
}
