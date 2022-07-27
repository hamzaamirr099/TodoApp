import 'package:flutter/material.dart';

class BottomSheetButton extends StatelessWidget {
  final TextEditingController controller;
  final String buttonText;
  Color? backgrounColor;

  BottomSheetButton(
      {Key? key, required this.controller, required this.buttonText, this.backgrounColor = Colors.green})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          width: double.infinity,
          height: 40.0,
          decoration: BoxDecoration(
            color: backgrounColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextButton(
            onPressed: () {
              controller.text = buttonText;
              Navigator.of(context).pop();
            },
            child: Text(
              buttonText,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }
}
