import 'package:flutter/material.dart';

void showDialogMessage(
    {
      required BuildContext context,
      VoidCallback? firstChoiceFunction,
      VoidCallback? secondChoiceFunction,
      required String title,
      required String body,
      String? firstActionName,
      String? secondActionName,

    }) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,

          ),
          content: Text(body, textAlign: TextAlign.center,),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: firstChoiceFunction,
                    child: Text(firstActionName ?? ""),
                  ),
                ),
                
                Expanded(
                  child: TextButton(
                    onPressed: secondChoiceFunction,
                    child: Text(secondActionName ?? ""),
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
