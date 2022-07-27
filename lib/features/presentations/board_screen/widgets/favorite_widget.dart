import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/bloc/cubit.dart';
import '../../../../core/utils/bloc/states.dart';
import '../../../../core/utils/widgets/task_item.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, CubitStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        if(AppCubit.get(context).favoriteTasks.isNotEmpty)
          {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if(AppCubit.get(context).dailyRepeatedTasks[index]['favorite'] == 1) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: TaskItem(taskData: AppCubit.get(context).dailyRepeatedTasks[index]),
                        );
                      }
                      return Container();
                    },
                    itemCount: AppCubit.get(context).dailyRepeatedTasks.length,

                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if(AppCubit.get(context).favoriteTasks[index]['repeat'] != "Daily") {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: TaskItem(taskData: AppCubit.get(context).favoriteTasks[index]),
                          );
                        }
                        return Container();
                      },
                      itemCount: AppCubit.get(context).favoriteTasks.length,
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
                  "No favorite tasks",
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
