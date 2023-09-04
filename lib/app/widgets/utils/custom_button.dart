import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    this.routes,
  });

  final String buttonText;
  final String? routes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(routes!);
        },
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: const MaterialStatePropertyAll(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ))),
        child: Text(buttonText),
      ),
    );
  }
}
