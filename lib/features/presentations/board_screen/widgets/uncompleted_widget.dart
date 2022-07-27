import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_algoriza/features/presentations/schedule_screen/pages/schedule_page.dart';

import '../../../../core/utils/bloc/cubit.dart';
import '../../../../core/utils/bloc/states.dart';
import '../../../../core/utils/widgets/task_item.dart';

class UncompletedWidget extends StatelessWidget {
  const UncompletedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, CubitStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        if(AppCubit.get(context).unCompletedTasks.isNotEmpty)
          {
            bool dailyTaskFounded = false;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView. builder(
                      itemBuilder: (context, index) {
                        if(AppCubit.get(context).unCompletedTasks[index]['repeat'] != "Daily") {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: TaskItem(taskData: AppCubit.get(context).unCompletedTasks[index]),
                          );
                        }
                        dailyTaskFounded = true;
                        return Container();
                      },
                      itemCount: AppCubit.get(context).unCompletedTasks.length,
                    ),
                  ),
                ],
              ),
            );
          }
        else
          {
            return const Center(
              child: Text(
                "No uncompleted tasks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            );
          }
      },
    );
  }
}
