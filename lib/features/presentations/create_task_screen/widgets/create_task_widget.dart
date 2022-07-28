import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_algoriza/core/utils/bloc/cubit.dart';
import 'package:todo_app_algoriza/core/utils/bloc/states.dart';
import 'package:todo_app_algoriza/core/utils/services/show_dialog_function.dart';
import 'package:todo_app_algoriza/core/utils/widgets/default_text_form_field.dart';

import '../../../../core/utils/widgets/bottom_sheet_button.dart';

class CreateTaskWidget extends StatelessWidget {
  CreateTaskWidget({Key? key}) : super(key: key);

  final formKey =
      GlobalKey<FormState>(); //this is to validate the text fields contents
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TimeOfDay? startTimeOfTask;
  DateTime? dateOfTask;

  var listItems = [
    "Before 10 minutes",
    "Before 30 minutes",
    "Before 1 hour",
    "Before 1 day"
  ];
  String dropDownValue = 'Before 10 minutes';

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Add task",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 80.0,
        elevation: 0.0,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey[300],
              height: 1.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DefaultTextFormField(
                        hintText: "Ex: Meeting",
                        controller: cubit.titleController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title must not be empty';
                          }
                          return null;
                        },
                        onTapFunction: () {},

                      ),
                      const Text(
                        "Date",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DefaultTextFormField(
                        hintText:
                            "Ex: ${DateFormat.yMMMd().format(DateTime.now())}",
                        keyboardType: TextInputType.none,
                        suffixIcon: Icons.keyboard_arrow_down_sharp,
                        controller: cubit.dateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date must not be empty';
                          }
                          return null;
                        },
                        onTapFunction: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse("2030-12-31"),
                          ).then((value) {
                            dateOfTask = value;
                            cubit.dateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Start time",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                DefaultTextFormField(
                                  hintText:
                                  "Ex: ${(DateFormat.Hm().format(DateTime.now()))}",
                                  keyboardType: TextInputType.none,
                                  controller: cubit.startTimeController,
                                  suffixIcon: Icons.watch_later_outlined,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Start time must not be empty';
                                    }
                                    return null;
                                  },
                                  onTapFunction: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      startTimeOfTask = value;
                                      cubit.startTimeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "End time",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                DefaultTextFormField(
                                  hintText:
                                      // "Ex: ${TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 5).format(context)}",
                                  "Ex: ${(DateFormat.Hm().format(DateTime.now().add(Duration(hours: 5))))}",
                                  keyboardType: TextInputType.none,
                                  controller: cubit.endTimeController,
                                  suffixIcon: Icons.watch_later_outlined,
                                  onTapFunction: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      cubit.endTimeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Remind me",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DefaultTextFormField(
                        hintText: "Don't remind me",
                        keyboardType: TextInputType.none,
                        controller: cubit.remindController,
                        suffixIcon: Icons.keyboard_arrow_down_sharp,
                        onTapFunction: () {
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.white,
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0 ,left: 20.0, right: 20.0),
                                  child: Container(
                                    height: 300.0,
                                    child: Column(
                                      children: [
                                        BottomSheetButton(
                                          buttonText: 'Before 10 minutes',
                                          controller: cubit.remindController,
                                        ),
                                        BottomSheetButton(
                                          buttonText: 'Before 30 minutes',
                                          controller: cubit.remindController,
                                        ),
                                        BottomSheetButton(
                                          buttonText: 'Before 1 hour',
                                          controller: cubit.remindController,
                                        ),
                                        BottomSheetButton(
                                          buttonText: 'Before 1 day',
                                          controller: cubit.remindController,
                                        ),
                                        BottomSheetButton(
                                          buttonText: "Don't remind me",
                                          controller: cubit.remindController,
                                          backgrounColor: Colors.red,
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              });
                          return;
                        },

                      ),
                      const Text(
                        "Repeat",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DefaultTextFormField(
                        hintText: "Weekly",
                        keyboardType: TextInputType.none,
                        onTapFunction: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0 ,left: 20.0, right: 20.0),
                                  child: Container(
                                    height: 180.0,
                                    child: Column(
                                      children: [
                                        BottomSheetButton(
                                          buttonText: 'Daily',
                                          controller: cubit.repeatController,
                                        ),
                                        BottomSheetButton(
                                          buttonText: 'Weekly',
                                          controller: cubit.repeatController,
                                        ),
                                        BottomSheetButton(
                                          buttonText: "Don't repeat",
                                          controller: cubit.repeatController,
                                          backgrounColor: Colors.red,
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              });
                          return;
                        },
                        suffixIcon: Icons.keyboard_arrow_down_sharp,
                        controller: cubit.repeatController,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Choose color",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      BlocConsumer<AppCubit, CubitStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Wrap(
                            children: List<Widget>.generate(4, (index) {
                              return InkWell(
                                onTap: () {
                                  cubit.colorSelection(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CircleAvatar(
                                    child: cubit.indexOfColor == index
                                        ? const Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          )
                                        : Container(),
                                    radius: 15.0,
                                    backgroundColor: index == 0
                                        ? Colors.red
                                        : index == 1
                                            ? Colors.orange
                                            : index == 2
                                                ? Colors.amber
                                                : Colors.blue,
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      debugPrint("the date of task is $dateOfTask");
                      debugPrint("the start time of task is $startTimeOfTask");
                      DateTime dateAndTimeOfTask = DateTime(
                          dateOfTask!.year,
                          dateOfTask!.month,
                          dateOfTask!.day,
                          startTimeOfTask!.hour,
                          startTimeOfTask!.minute);
                      Duration difference =
                          dateAndTimeOfTask.difference(DateTime.now());
                      debugPrint("the difference is $difference");
                      if (difference.isNegative) {
                        showDialogMessage(
                          context: context,
                          title: "Warning!",
                          body:
                              "This time has passed, please pick another start time",
                        );
                      } else {
                        cubit.insertToDatabase();
                        if (cubit.remindController.text != "" &&
                            cubit.remindController.text != "Don't remind me") {
                          debugPrint("in the specified block");
                          Future.delayed(const Duration(seconds: 1), () {
                            //to make sure that data has been fetched (question in that part)
                            cubit.getTimeOfNotification(dateAndTimeOfTask);
                          });
                        }
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: const Text(
                    "Create a Task",
                    style: TextStyle(color: Colors.white),
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
