import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String? hintText;
  final String? initValue;
  final Widget? icon;
  final bool obscureText;
  final bool? enable;
  final bool? autofocus;
  var keyboardType;
  String? Function(String? value)? validateFunc;

  CustomTextFormField({
    super.key,
    required this.textEditingController,
    required this.labelText,
    this.initValue,
    this.icon,
    this.hintText,
    this.enable,
    this.autofocus,
    required this.obscureText,
    this.keyboardType,
    this.validateFunc,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: TextFormField(
            controller:
                widget.initValue == null ? widget.textEditingController : null,
            initialValue: widget.initValue ?? widget.initValue,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            enabled: widget.enable != null ? false : true,
            autofocus: widget.autofocus != null ? true : false,
            decoration: InputDecoration(
                prefixIcon: widget.icon ?? widget.icon,
                labelText: widget.labelText,
                labelStyle: const TextStyle(color: Colors.black),
                // hintText: widget.hintText,
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
            validator: widget.validateFunc ?? (value) => null,
          ),
        )
      ],
    );
  }
}
