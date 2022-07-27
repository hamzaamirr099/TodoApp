import 'package:flutter/material.dart';
import 'package:todo_app_algoriza/core/utils/bloc/cubit.dart';
import 'package:todo_app_algoriza/core/utils/services/show_dialog_function.dart';

class TaskItem extends StatelessWidget {
  final Map taskData;

  const TaskItem({
    Key? key,
    required this.taskData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDaily = false;
    if(taskData['repeat'] == "Daily")
      {
        isDaily = true;
      }
    return InkWell(
      onTap: () {},
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isDaily ? Colors.black : Colors.white,
        ),

        child: Row(
          children: [
            Transform.scale(
              scale: isDaily? 1.2: 1.6,
              child: taskData['repeat'] == "Daily" ? const Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: Icon(Icons.push_pin_outlined, color: Colors.white,),
              ) : Checkbox(
                shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                fillColor: MaterialStateProperty.all(
                    taskData['colorIndex'] == 0? Colors.red :
                    taskData['colorIndex'] == 1? Colors.orange :
                    taskData['colorIndex'] == 2? Colors.amber :
                    Colors.blue
                ),

                value: taskData['status'] == 'Completed' ? true : false,
                onChanged: (value) {
                  if (value == true) {
                    AppCubit.get(context).updateStatus("Completed", taskData['id']);
                  } else {
                    AppCubit.get(context).updateStatus("new", taskData['id']);
                  }
                },
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                "${taskData['title']}",
                style: TextStyle(
                  fontSize: 18.0,
                  color: isDaily ? Colors.white : null,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            IconButton(
              onPressed: () {
                int favoriteUpdate;
                if (taskData['favorite'] == 1) {
                  favoriteUpdate = 0;
                } else {
                  favoriteUpdate = 1;
                }
                debugPrint("favor is ->> $favoriteUpdate");
                AppCubit.get(context)
                    .makeItFavorite(favoriteUpdate, taskData['id']);
              },
              icon: Icon(
                taskData['favorite'] == 1
                    ? Icons.star
                    : Icons.star_border_outlined,
                color: Colors.amber,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialogMessage(
                    context: context,
                    firstChoiceFunction: () {
                      Navigator.pop(context);
                    },
                    secondChoiceFunction: () {
                      AppCubit.get(context).service.cancelNotification(taskData['id']);
                      AppCubit.get(context).deleteTask(taskData['id']);
                      Navigator.pop(context);
                    },
                    title: "Delete",
                    body: "Do you want to delete this task?",
                    firstActionName: "Cancel",
                    secondActionName: "Delete");
              },
              icon: Icon(
                Icons.delete_outlined,
                color: isDaily ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
