import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String? hintText;

  const CustomTextFormField(
      {super.key,
      required this.textEditingController,
      required this.labelText,
      this.hintText});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(widget.labelText),
        // const SizedBox(
        //   height: 8,
        // ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: TextFormField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
                labelText: widget.labelText,
                labelStyle: const TextStyle(color: Colors.black),
                // hintText: widget.hintText,
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
        )
      ],
    );
  }
}
