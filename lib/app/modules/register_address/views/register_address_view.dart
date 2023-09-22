import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/app/widgets/utils/custom_button.dart';

import '../controllers/register_address_controller.dart';

class RegisterAddressView extends GetView<RegisterAddressController> {
  const RegisterAddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(
            () => controller.isLoading.value
                ? CircularProgressIndicator() // Show loading indicator
                : Column(
                    children: [
                      const Text(
                        'Address Information',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.PICK_ADDRESS);
                                },
                                child: Text(Get.find<PickAddressController>()
                                            .draggedAddress
                                            .value ==
                                        ""
                                    ? "Select Address"
                                    : Get.find<PickAddressController>()
                                        .draggedAddress
                                        .value)),
                            const SizedBox(height: 50),
                            CustomButton(
                              buttonText: 'Confirm',
                              onPressed: () => controller.registerData(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
