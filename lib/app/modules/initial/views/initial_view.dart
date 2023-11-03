import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/app/styles/space.dart';
import 'package:school_bus/app/styles/stye.dart';
import 'package:school_bus/app/widgets/utils/custom_button.dart';
import '../controllers/initial_controller.dart';

class InitialView extends GetView<InitialController> {
  const InitialView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              'assets/images/person_map.svg',
              width: Style.widthLg(context),
            ),
            const SizedBox(
              height: 120,
            ),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      ' School Bus',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Space.md,
                Container(
                  alignment: Alignment.center,
                  width: Style.widthLg(context),
                  child: const Text(
                    'Join now, for peace of mind, safety, \n and reliable tracking of your child',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontSize: 18, height: 1.5),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            CustomButton(
              buttonText: 'Get started',
              onPressed: () {
                Get.toNamed(Routes.LOGIN);
              },
            ),
            Space.lg
            // const CustomLightButton(
            //   buttonText: 'Login',
            //   routes: Routes.LOGIN,
            // ),
            // const SizedBox(
            //   height: 18,
            // ),
            // const CustomLightButton(
            //   buttonText: 'Register',
            //   routes: Routes.REGISTER,
            // )
          ],
        ),
      ),
    ));
  }
}
