import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/bloc/cubit.dart';
import '../../../../core/utils/bloc/states.dart';
import '../../../../core/utils/widgets/task_item.dart';

class CompletedWidget extends StatelessWidget {
  const CompletedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, CubitStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        if(AppCubit.get(context).completedTasks.isNotEmpty)
          {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                          return TaskItem(taskData: AppCubit.get(context).completedTasks[index]);
                      },
                      itemCount: AppCubit.get(context).completedTasks.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 15.0);
                      },
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
                "No completed tasks",
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
