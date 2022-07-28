import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_algoriza/core/utils/bloc/cubit.dart';
import 'package:todo_app_algoriza/core/utils/bloc/states.dart';
import '../../../../core/utils/widgets/task_item.dart';

class AllWidget extends StatelessWidget {
  const AllWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, CubitStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        if(AppCubit.get(context).allTasks.isNotEmpty)
          {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children:
                        AppCubit.get(context).dailyRepeatedTasks
                            .map((taskItem) => Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: TaskItem(taskData: taskItem),
                            ))
                            .toList()..addAll(
                          AppCubit.get(context).nonRepeatedTasks
                              .map((taskItem) => Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: TaskItem(taskData: taskItem),
                              ),
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            );
          }
        else{
          return const Center(
            child: Text(
              "No tasks",
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
