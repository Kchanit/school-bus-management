import 'package:flutter/material.dart';

import '../../styles/stye.dart';

class CustomErrorLightButton extends StatelessWidget {
  CustomErrorLightButton({
    super.key,
    required this.buttonText,
    this.routes,
    this.onPressed,
    this.icon,
  });
  final String buttonText;
  Widget? icon;
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
            backgroundColor: MaterialStatePropertyAll(Colors.red[100]),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Colors.transparent)))),
        child: icon == null
            ? Text(buttonText,
                style: TextStyle(color: Colors.red[900], fontSize: 16))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(buttonText,
                      style: TextStyle(color: Colors.red[900], fontSize: 16)),
                  const SizedBox(
                    width: 8,
                  ),
                  icon!
                ],
              ),
      ),
    );
  }
}
