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
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TaskItem(taskData: AppCubit.get(context).dailyRepeatedTasks[index]);
                    },
                    itemCount: AppCubit.get(context).dailyRepeatedTasks.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 15.0);
                    },
                  ),
                  const SizedBox(height: 15.0,),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return TaskItem(taskData: AppCubit.get(context).nonRepeatedTasks[index]);
                      },
                      itemCount: AppCubit.get(context).nonRepeatedTasks.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 15.0);
                      },
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
