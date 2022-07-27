import 'package:flutter/material.dart';

class TaskInThatDay extends StatelessWidget {
  final Map taskData;
  const TaskInThatDay({Key? key, required this.taskData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Container(
        height: 90.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: taskData["repeat"] == "Daily" ? Colors.black
              : taskData['colorIndex'] == 0
              ? Colors.red
              : taskData['colorIndex'] == 1
              ? Colors.orange
              : taskData['colorIndex'] == 2
              ? Colors.amber
              : Colors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 20.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${taskData['startTime']}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 5.0,),
                  Text(
                    "${taskData['title']}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Icon(
                taskData['repeat'] == "Daily" ? Icons.push_pin_outlined : taskData['status'] == 'Completed'? Icons.check_circle_outline_sharp : Icons.radio_button_unchecked,
                color: Colors.white,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
