import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InputField extends StatelessWidget {
  final RegExp? reg;
  final String er1;
  final String? er2;
  final TextInputType inputType;
  final TextEditingController controller;
  final String label;
  final IconButton? sicon;
  final bool? pass;
  const InputField(
      {super.key,
      this.reg,
      required this.er1,
      this.er2,
      required this.inputType,
      required this.controller,
      required this.label,
      this.sicon,
      this.pass});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return er1;
          }
          if (reg != null && !reg!.hasMatch(value)) {
            return er2;
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: inputType,
        controller: controller,
        obscureText: pass ?? false,
        decoration: InputDecoration(
          suffixIcon: sicon,
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(color: Colors.black)),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(color: Colors.black)),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
