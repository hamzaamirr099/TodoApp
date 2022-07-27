import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {

  String? hintText;
  Function? validatorFunction;
  String? Function(String?)? validator;
  TextEditingController? controller;
  VoidCallback? onTapFunction;
  TextInputType? keyboardType;
  IconData? prefixIcon;
  IconData? suffixIcon;

  DefaultTextFormField({
    Key? key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.validatorFunction,
    this.onTapFunction,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        onTap: onTapFunction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
          prefixIconConstraints: const BoxConstraints(maxWidth: 20.0),
          prefixIcon: Icon(prefixIcon,),
          suffixIcon: Icon(suffixIcon,),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: const BorderSide(
              width: 0.0, style: BorderStyle.none)),
          filled: true,
          fillColor: Colors.grey[100],

        ),
        textAlignVertical: TextAlignVertical.center,


      ),
    );
  }
}
