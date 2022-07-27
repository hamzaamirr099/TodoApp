import 'package:flutter/material.dart';
import 'package:todo_app_algoriza/core/utils/bloc/cubit.dart';
import 'package:todo_app_algoriza/core/utils/services/show_dialog_function.dart';
import 'package:todo_app_algoriza/features/presentations/board_screen/widgets/uncompleted_widget.dart';
import 'package:todo_app_algoriza/features/presentations/create_task_screen/pages/create_task_page.dart';
import '../../schedule_screen/pages/schedule_page.dart';
import 'all_widget.dart';
import 'completed_widget.dart';
import 'favorite_widget.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Board",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: Colors.black),
          ),
          toolbarHeight: 80.0,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                if (AppCubit.get(context).allTasks.isNotEmpty) {
                  showDialogMessage(
                      context: context,
                      firstChoiceFunction: () {
                        Navigator.pop(context);
                      },
                      secondChoiceFunction: () {
                        AppCubit.get(context).service.cancelAllNotifications();
                        AppCubit.get(context).deleteAllRecords();
                        Navigator.pop(context);
                      },
                      title: "Delete",
                      body: "Do you want to delete all tasks?",
                      firstActionName: "Cancel",
                      secondActionName: "Delete",
                  );
                }
              },
              icon: const Icon(
                Icons.delete_outlined,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SchedulePage()));
              },
              icon: const Icon(
                Icons.calendar_today_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey[300],
              height: 1.0,
            ),
            Container(
              height: 60.0,
              child: const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontSize: 16.0),
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    text: "All",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                  Tab(
                    text: "Uncompleted",
                  ),
                  Tab(
                    text: "Favorite",
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.grey[300],
              height: 1.0,
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  AllWidget(),
                  CompletedWidget(),
                  UncompletedWidget(),
                  FavoriteWidget(),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.green),
                child: TextButton(
                  onPressed: () {
                    AppCubit.get(context).resetControllers();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateTaskPage()));
                  },
                  child: const Text(
                    "Add a task",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
