import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekDayItem extends StatelessWidget {

  final int indexOfSelectedItem;
  final int index;
  const WeekDayItem({Key? key, required this.index, this.indexOfSelectedItem = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      child: Container(
        width:50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: indexOfSelectedItem == index? Colors.green : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEE').format(DateTime.now().add(Duration(days: index))),
              style: TextStyle(color:  indexOfSelectedItem == index? Colors.white : Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0,),
            Text(
              "${DateTime.now().add(Duration(days: index)).day}",
              style: TextStyle(color:  indexOfSelectedItem == index? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
