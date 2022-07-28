import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_algoriza/core/utils/bloc/cubit.dart';
import 'package:todo_app_algoriza/core/utils/bloc/states.dart';
import 'package:todo_app_algoriza/core/utils/widgets/week_day_item.dart';
import 'package:todo_app_algoriza/features/presentations/schedule_screen/widgets/task_in_that_day.dart';

class ScheduleWidget extends StatelessWidget {
  ScheduleWidget({Key? key}) : super(key: key);
  DateTime dateOfTheSelectedDay = DateTime.now();
  int indexOfSelectedItem = 0;

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context)
        .getTasksOfTheDay(DateFormat.yMMMd().format(DateTime.now()));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Schedule",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 80.0,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey[300],
            height: 1.0,
          ),
          BlocConsumer<AppCubit, CubitStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: 90.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: WeekDayItem(
                              index: index,
                              indexOfSelectedItem: indexOfSelectedItem,
                            ),
                            onTap: () {
                              indexOfSelectedItem = index;
                              debugPrint("selected item is $indexOfSelectedItem");
                              dateOfTheSelectedDay =
                                  DateTime.now().add(Duration(days: index));
                              String nameOfSelectedDate =
                                  DateFormat.yMMMd().format(dateOfTheSelectedDay);
                              debugPrint(nameOfSelectedDate);
                              AppCubit.get(context)
                                  .getTasksOfTheDay(nameOfSelectedDate);
                            },
                          );
                        },
                        itemCount: 7,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    height: 1.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Text(
                          DateFormat('EEEE').format(dateOfTheSelectedDay),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        const Spacer(),
                        Text(
                          DateFormat.yMMMMd().format(dateOfTheSelectedDay),
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          BlocConsumer<AppCubit, CubitStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (AppCubit.get(context).dailyRepeatedTasks.isNotEmpty || AppCubit.get(context).tasksOfTheDay.isNotEmpty) {
                return Expanded(
                  child: ListView(
                    children: AppCubit.get(context)
                        .dailyRepeatedTasks
                        .map((taskItem) {
                          // DateTime dateOfTask = DateTime.parse(taskItem["date"]);
                      // DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(taskItem["date"]);
                      // if(dateOfTheSelectedDay.isAfter(tempDate))
                      //   {
                      //     return Container(child: TaskInThatDay(taskData: taskItem));
                      //   }
                      return Container(child: TaskInThatDay(taskData: taskItem));

                    }).toList()
                      ..addAll(
                        AppCubit.get(context).tasksOfTheDay.map(
                              (taskItem) {
                            if (taskItem['repeat'] != "Daily") {
                              return Container(child: TaskInThatDay(taskData: taskItem));
                            }
                            return Container();
                          },
                        ),
                      ),
                  ),
                );
              } else {
                return Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "No tasks in that day",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ]),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
// Padding(
//   padding: const EdgeInsets.symmetric(vertical: 15.0),
//   child: DatePicker(
//     DateTime.now(),
//     initialSelectedDate: DateTime.now(),
//     selectionColor: Colors.green,
//     selectedTextColor: Colors.white,
//     onDateChange: (date) {
//       // New date selected
//       // print(DateFormat.yMMMd().format(date));
//       dateOfTheSelectedDay = date;
//       String selectedDate = DateFormat.yMMMd().format(date);
//       print(selectedDate);
//       AppCubit.get(context).getTasksOfTheDay(selectedDate);
//     },
//     height: 90.0,
//     daysCount: 7,
//     width: (MediaQuery.of(context).size.width / 8),
//   ),
// ),
