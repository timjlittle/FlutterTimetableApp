
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt2/models/timetable.dart';
import 'package:tt2/main.dart';
import 'package:intl/intl.dart';
import 'package:tt2/screens/day.dart';

class WeekPage extends StatelessWidget {
  DateTime currentDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    //TimetableModel timetable = appState.timetable;


    while (currentDay.weekday > 1) {
      currentDay.add(Duration(days: -1));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DayPage(),
        DayPage(),
        DayPage(),
        DayPage(),
        DayPage(),
      ],
    );
  }

}