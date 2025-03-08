
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt2/models/timetable.dart';
import 'package:tt2/main.dart';
import 'package:intl/intl.dart';
import 'package:tt2/screens/day.dart';

class WeekDayPage extends StatelessWidget {
  const WeekDayPage({super.key});



  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    //TimetableModel timetable = appState.timetable;
    TimetableModel timetable = Provider.of<TimetableModel>(context);

    DateTime currentDay = appState.currentDay;



    // while (currentDay.weekday > 5){
    //   currentDay.add(Duration(days:1));
    // }
    // print ("build week day");
    // print (currentDay.weekday.toString());
    int dayNum = currentDay.weekday;

    return ListView(

      children: [

        Container(
            height: 56.0,
            decoration: BoxDecoration(color: Colors.blue[400],
                border: Border.all(
                    width: 1,
                    color: Colors.black
                ),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10),
            child: Column (
                children : [

                  Text(DateFormat('EEEEE').format(currentDay),
                    textAlign: TextAlign.center, style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),),

                ]))
            ,
        for (int lessNo = 0; lessNo < timetable.numPeriods; lessNo++)

          timetable.getLessonkey(dayNum, lessNo) == appState.toEdit ?
          //EdittableLesson(lesson, appState.toEdit, appState.handleEditClick) :
          //StaticLesson (lesson, appState.toEdit, appState.handleEditClick),
          EdittableLesson(key : ValueKey<String>(timetable.getLessonkey(dayNum, lessNo)), dayNo: dayNum, lessNo: lessNo, saveFunction : appState.handleEditClick, lessonKey : timetable.getLessonkey(dayNum, lessNo)) :
          StaticLesson (key : ValueKey<String>(timetable.getLessonkey(dayNum, lessNo)), dayNum:dayNum, lessNo:lessNo, saveFunction : appState.handleEditClick, lessonKey : timetable.getLessonkey(dayNum, lessNo)),
      ],

    );
  }
}


class WeekPage extends StatelessWidget {
  DateTime currentDay = DateTime.now();

  WeekPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    //TimetableModel timetable = appState.timetable;

    //print ("week day");
    while (currentDay.weekday > 1) {
      currentDay = currentDay.subtract(const Duration(days: 1));
      //print(currentDay.weekday);
    }

    //print (currentDay.weekday.toString());

    return Row(
        children: [


        Flexible(
                //fit:FlexFit.loose,
         child: DayPage(currentDay:currentDay, showArrows:false)),
            //width : 100,
          Flexible(//fit:FlexFit.loose,
            child: DayPage(currentDay:currentDay.add(const Duration(days:1)), showArrows:false)),
          Flexible(//fit:FlexFit.loose,
            //width : 100,
            child: DayPage(currentDay:currentDay.add(const Duration(days:2)), showArrows:false)),
          Flexible(//fit:FlexFit.loose,
            //width : 100,
            child: DayPage(currentDay:currentDay.add(const Duration(days:3)), showArrows:false)),
          Flexible(//fit:FlexFit.loose,
            //width : 100,
            child: DayPage(currentDay:currentDay.add(const Duration(days:4)), showArrows:false)),
      ],
    )


    ;
  }

}