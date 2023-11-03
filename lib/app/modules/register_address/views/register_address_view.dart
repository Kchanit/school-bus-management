import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/app/widgets/utils/custom_button.dart';
import 'package:school_bus/app/widgets/utils/custom_light_button.dart';

import '../../../styles/space.dart';
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
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/arrow-left.svg'),
          onPressed: () {
            Get.offAndToNamed(Routes.SELECT_STUDENT);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Address Information',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Space.sm,
                const Text(
                  'Press a button below to select an address.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => controller.isLoading.value
                ? const CircularProgressIndicator() // Show loading indicator
                : Form(
                    // key: controller.formKey,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          SizedBox(
                            width: Get.find<PickAddressController>()
                                        .draggedAddress
                                        .value ==
                                    ""
                                ? MediaQuery.of(context).size.width * 0.5
                                : null,
                            child: CustomLightButton(
                                onPressed: () {
                                  Get.toNamed(Routes.PICK_ADDRESS);
                                },
                                buttonText: Get.find<PickAddressController>()
                                            .draggedAddress
                                            .value ==
                                        ""
                                    ? "Select Address"
                                    : Get.find<PickAddressController>()
                                        .draggedAddress
                                        .value),
                          ),
                          const SizedBox(height: 25),
                          Obx(
                            () => Column(
                              children: [
                                if (controller.districtMessage.value != '')
                                  Text(
                                    controller.districtMessage.value,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                const SizedBox(height: 25),
                                if (controller.streetMessage.value != '')
                                  Text(
                                    controller.streetMessage.value,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          CustomButton(
                            buttonText: 'Confirm',
                            onPressed: () => controller.registerData(),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
