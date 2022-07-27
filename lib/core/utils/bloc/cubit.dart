import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_algoriza/core/utils/bloc/states.dart';
import 'package:todo_app_algoriza/features/presentations/board_screen/widgets/all_widget.dart';
import 'package:todo_app_algoriza/features/presentations/board_screen/widgets/completed_widget.dart';
import 'package:todo_app_algoriza/features/presentations/board_screen/widgets/favorite_widget.dart';
import 'package:todo_app_algoriza/features/presentations/board_screen/widgets/uncompleted_widget.dart';
import '../services/local_notification_service.dart';

class AppCubit extends Cubit<CubitStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;
  int screenIndex = 0;

  late final LocalNotificationService service;

  //controllers of (Add task page)
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController remindController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
  int indexOfColor = 0;

  List<Widget> pages = [
    const AllWidget(),
    const CompletedWidget(),
    const UncompletedWidget(),
    const FavoriteWidget(),
  ];

  void colorSelection(int index) {
    indexOfColor = index;
    emit(ColorSelectionState());
  }

  void initialization() {
    service = LocalNotificationService();
    service.initialize();

    createDatabase();
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint("database created");
        database
            .execute(
                "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, startTime TEXT, endTime TEXT, remind TEXT, repeat TEXT, status TEXT, favorite INTEGER, colorIndex INTEGER)")
            .then((value) {
          debugPrint("table created");
          emit(DatabaseCreatedState());
        }).catchError((error) {
          debugPrint("error when creating table is ${error.toString()}");
        });
      },
      onOpen: (database) {
        debugPrint("database opened");
        emit(DatabaseOpenedState());
      },
    );

    getAllTasks();
  }

  Future<void> insertToDatabase() async {
    database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks (title, date, startTime, endTime, remind, repeat, status, favorite, colorIndex) VALUES("${titleController.text}", "${dateController.text}", "${startTimeController.text}", "${endTimeController.text}", "${remindController.text}", "${repeatController.text}", "new", 0, $indexOfColor)');
    }).then((value) {
      debugPrint('New Task Inserted');

      getAllTasks();
      // emit(NewTaskCreatedState());
    });
  }

  List<Map> tasksOfTheDay = [];

  void getTasksOfTheDay(String date) {
    database
        .rawQuery('SELECT * FROM tasks WHERE date = ?', [date]).then((value) {
      tasksOfTheDay = value;
      debugPrint(tasksOfTheDay.toString());
      emit(TaskInThatDayState());
    });
  }

  void updateStatus(String status, int id) async {
    int count = await database
        .rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [status, '$id']);
    debugPrint('updated: $count');
    getAllTasks();
  }

  void makeItFavorite(int value, int id) async {
    int count = await database
        .rawUpdate('UPDATE tasks SET favorite = ? WHERE id = ?', [value, id]);
    debugPrint('updated: $count');
    getAllTasks();
  }

  List<Map> allTasks = [];
  List<Map> completedTasks = [];
  List<Map> favoriteTasks = [];
  List<Map> unCompletedTasks = [];
  List<Map> dailyRepeatedTasks = [];
  List<Map> nonRepeatedTasks = [];

  void getAllTasks() {
    completedTasks = [];
    favoriteTasks = [];
    unCompletedTasks = [];
    dailyRepeatedTasks = [];
    nonRepeatedTasks = [];

    database.rawQuery('SELECT * FROM tasks').then((value) {
      debugPrint('Users Data Fetched');
      allTasks = value;
      debugPrint(allTasks.toString());
      if (allTasks.isEmpty) {
        completedTasks = [];
        favoriteTasks = [];
        unCompletedTasks = [];
        dailyRepeatedTasks = [];
      }
      for (var task in allTasks) {
        if (task['status'] == "Completed") {
          completedTasks.add(task);
        } else if (task['status'] == "new") {
          unCompletedTasks.add(task);
        }

        if (task['favorite'] == 1) {
          favoriteTasks.add(task);
        }
        if (task['repeat'] == "Daily") {
          dailyRepeatedTasks.add(task);
        }else{
          nonRepeatedTasks.add(task);
        }
      }

      // resetControllers();
      emit(DataOfAllTasksState());
    });
  }

  void resetControllers() {
    titleController.clear();
    dateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    remindController.clear();
    repeatController.clear();
  }

  void deleteTask(int id) async {
    await database.execute("DELETE FROM tasks Where id = $id");
    debugPrint('one task deleted');
    getAllTasks();
  }

  void deleteAllRecords() async {
    await database.execute("DELETE FROM tasks");
    debugPrint('rows deleted');
    getAllTasks();
  }

  void getTimeOfNotification(DateTime dateAndTimeOfTask) async {
    DateTime?
        newTime; //carry the time after subtract (10 min, 30 min, 1 hour, or 1 day)

    debugPrint("the remind controller is ${remindController.text}");
    if (remindController.text == "Before 10 minutes") {
      newTime = dateAndTimeOfTask.subtract(const Duration(minutes: 10));
    } else if (remindController.text == "Before 30 minutes") {
      newTime = dateAndTimeOfTask.subtract(const Duration(minutes: 30));
    } else if (remindController.text == "Before 1 hour") {
      newTime = dateAndTimeOfTask.subtract(const Duration(hours: 1));
    } else if (remindController.text == "Before 1 day") {
      newTime = dateAndTimeOfTask.subtract(const Duration(days: 1));
    }

    debugPrint("You must be notified in this date and time $newTime");

    Duration difference2 = newTime!.difference(DateTime.now());
    debugPrint("The new difference is $difference2");
    if (difference2.isNegative) {
      service.showNotification(
        id: 1000000,
        title: "Warning",
        body: "Can't notify you in this time, please update your reminder",
      );

    } else {
      int days = difference2.inDays;
      int hours = difference2.inHours.remainder(24);
      int minutes = difference2.inMinutes.remainder(60);

      service.showNotification(
        id: 1000000 + allTasks.last['id'] as int,
        title: "New task",
        body: days > 0
            ? "will notify you after $days days, $hours hours, and $minutes minutes, to do (${allTasks.last['title']}) task"
            : hours > 0
                ? "will notify you after $hours hours, and $minutes minutes, to do (${allTasks.last['title']}) task"
                : "will notify you after $minutes minutes, to do (${allTasks.last['title']}) task",
      );
      startCountDown(days, hours, minutes);
    }
  }

  void startCountDown(int days, int hours, int minutes) async {
    debugPrint(
        "the id of this task ${allTasks.last['title']} is ${allTasks.last['id']}");
    await service.showScheduledNotification(
      id: allTasks.last['id'],
      title: "Don't forget your task",
      body:
          "Your task (${titleController.text}) will start after${remindController.text.replaceAll("Before", "")}",
      days: days,
      hours: hours,
      minutes: minutes,
    );
  }
}
