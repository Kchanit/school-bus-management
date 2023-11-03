import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/app/styles/space.dart';
import 'package:school_bus/app/widgets/utils/custom_light_button.dart';
import 'package:school_bus/app/widgets/utils/custom_textfield.dart';
import '../../../../controllers/user_controller.dart';
import '../../../services/auth_service.dart';
import '../../../styles/stye.dart';
import '../../../widgets/utils/custom_error_light_button.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  SettingView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  myAlert(context) {
    return Get.defaultDialog(
      title: 'Please choose media to select.',
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: SizedBox(
        // height: MediaQuery.of(context).size.height / 6,
        child: Column(
          children: [
            ElevatedButton(
              //if user click this button, user can upload image from gallery
              onPressed: () {
                Navigator.pop(context);
                controller.getImage(ImageSource.gallery);
              },
              child: const Row(
                children: [
                  Icon(Icons.image),
                  SizedBox(
                    width: 10,
                  ),
                  Text('From Gallery'),
                ],
              ),
            ),
            ElevatedButton(
              //if user click this button. user can upload image from camera
              onPressed: () {
                Navigator.pop(context);
                controller.getImage(ImageSource.camera);
              },
              child: const Row(
                children: [
                  Icon(Icons.camera),
                  SizedBox(
                    width: 10,
                  ),
                  Text('From Camera'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.grey[800]),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/arrow-left.svg'),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.125,
                      decoration: BoxDecoration(color: Style.primaryColor),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    CustomTextFormField(
                        textEditingController: emailController,
                        labelText: Get.find<UserController>()
                            .currentUser
                            .value!
                            .fullName,
                        icon: const Icon(Icons.person),
                        enable: false,
                        obscureText: false),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextFormField(
                        textEditingController: emailController,
                        labelText:
                            Get.find<UserController>().currentUser.value!.email,
                        icon: const Icon(Icons.mail_rounded),
                        enable: false,
                        obscureText: false),
                    Space.lg,
                    SizedBox(
                      width: Style.widthMd(context),
                      child: ListTile(
                        title: const Text('Change password'),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey[400]!, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onTap: () {
                          Get.toNamed(Routes.CHANGE_PASSWORD);
                        },
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 220,
                    ),
                    if (Get.find<UserController>().currentUser.value!.role ==
                        'DRIVER')
                      CustomErrorLightButton(
                        buttonText: 'Logout',
                        onPressed: () {
                          AuthService().logout();
                        },
                        icon: SvgPicture.asset(
                          'assets/images/box-arrow-right.svg',
                          color: Colors.red[700],
                        ),
                      ),
                  ],
                ),
                Column(
                  children: [
                    controller.image.value != null
                        ? Container(
                            height: 85,
                            width: 85,
                            margin: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.075),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.file(
                                //to show image, you type like this.
                                File(controller.image.value!.path),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                              ),
                            ))
                        : Container(
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            margin: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.075),
                            child: const ClipRRect(
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.grey,
                                size: 85,
                              ),
                            ),
                          ),
                    if (Get.find<UserController>().currentUser.value!.role ==
                        'DRIVER')
                      TextButton(
                          onPressed: () {
                            myAlert(context);
                          },
                          child: const Text('Edit picture'))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
