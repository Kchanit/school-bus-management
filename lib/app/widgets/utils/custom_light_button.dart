import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../styles/stye.dart';

class CustomLightButton extends StatelessWidget {
  const CustomLightButton({
    super.key,
    required this.buttonText,
    this.routes,
    this.onPressed,
  });
  final String buttonText;
  final String? routes;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          // Get.toNamed(routes!);
          onPressed!();
        },
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStatePropertyAll(Style.lightPrimaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.transparent)))),
        child: Text(
          buttonText,
          style: TextStyle(color: Style.primaryColor, fontSize: 16),
        ),
      ),
    );
  }
}
