
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt2/models/timetable.dart';
import 'package:tt2/models/lesson.dart';
import 'package:tt2/main.dart';
import 'package:intl/intl.dart';

class EdittableLesson extends StatelessWidget {
  int lessNo;
  int dayNo;
  late ValueChanged<String> saveFunction;
  String lessonKey;
  late TimetableModel timetable;

  final TextEditingController _subject = TextEditingController();
  final TextEditingController teacher = TextEditingController();
  final TextEditingController classroom = TextEditingController();

  @override
  void dispose() {
    _subject.dispose();
    teacher.dispose();
    classroom.dispose();
    //super.dispose();
  }

  EdittableLesson({required Key key, required this.dayNo, required this.lessNo, required this.saveFunction, required this.lessonKey})  : super(key: key);

  _localSavePressed() {

    timetable.setLessonDetails(dayNo, lessNo, _subject.value.text, classroom.value.text, teacher.value.text);
    timetable.save();

     saveFunction ("");
  }

  _localDiscardPressed() {

    saveFunction ("X");
  }

  @override
  Widget build(BuildContext context) {

    timetable = Provider.of<TimetableModel>(context);

    _subject.text = timetable.getLessonSubject(dayNo, lessNo);
    teacher.text = timetable.getLessonTeacher(dayNo, lessNo);
    classroom.text = timetable.getLessonRoom(dayNo, lessNo);

    return Container(
      decoration: BoxDecoration(
          color : const Color(0xfff3f3db),
          border: Border.all(
              width: 1,
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(10)
      ),
          child: Column(
            children: <Widget>[
              Row (
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.lightBlueAccent.shade400,
                      child: Text(timetable.getLessonName(dayNo, lessNo)),
                    ),
                    Spacer(),
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.centerRight,
                      icon: (const Icon(Icons.check)),
                      color: Colors.green,
                      onPressed: _localSavePressed,
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.centerRight,
                      icon: (const Icon(Icons.close)),
                      color: Colors.red,
                      onPressed: _localDiscardPressed,
                    ),
                  ]
              ),

              Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _subject,
                    autocorrect: false,
                    enabled: true,
                    decoration: InputDecoration(hintText: 'Subject/Class name'),
                  )
              ),

              Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: classroom,
                    autocorrect: false,
                    decoration: InputDecoration(hintText: 'Classroom'),
                  )
              ),

              Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: teacher,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: 'Teacher'),
                  )
              ),


              /*
              RaisedButton(
                onPressed: () => getItemAndNavigate(context),
                color: Color(0xffFF1744),
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                    'Click Here To Send All Entered Items To Next Screen'),
              ),*/

            ],
          ),
        );
  }
}

class StaticLesson extends StatelessWidget {
  int lessNo;
  int dayNum;
  late ValueChanged<String> saveFunction;
  String lessonKey;

  StaticLesson ({required Key key, required this.dayNum, required this.lessNo, required this.saveFunction, required this.lessonKey})  : super(key: key);

  _localEditClick (){
    saveFunction(lessonKey);
  }

  @override
  Widget build(BuildContext context) {

    TimetableModel timetable = Provider.of<TimetableModel>(context);

    return Padding(
    padding: EdgeInsets.all(1.0),
    child : GestureDetector(
      onLongPress: _localEditClick,
      child:Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black
        ),
            borderRadius: BorderRadius.circular(10)
        ),

      child: ListTile(
    leading: CircleAvatar(
    backgroundColor: Colors.lightBlueAccent.shade400,
      child: Text(timetable.getLessonName(dayNum, lessNo)),
    ),
    title:Row (
    children : [
    Flexible( child:Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
      children : [

            Text(timetable.getLessonSubject(dayNum, lessNo), overflow: TextOverflow.ellipsis,),
        Text(timetable.getLessonRoom(dayNum, lessNo),overflow: TextOverflow.ellipsis,),
        ])),
        // Spacer(),
        // IconButton(
        //   padding: const EdgeInsets.all(0),
        //   alignment: Alignment.centerRight,
        //   icon: (const Icon(Icons.edit)),
        //   color: Colors.blue[500],
        //   onPressed: _localEditClick,
        // ),
    ]),
      ),
    ),
    ));
  }

}

class DayPage extends StatelessWidget {
  DateTime currentDay;
  bool showArrows;

  DayPage ({required this.currentDay, required this.showArrows});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    //TimetableModel timetable = appState.timetable;
    TimetableModel timetable = Provider.of<TimetableModel>(context);

    // DateTime currentDay = appState.currentDay;
    //
    // //print ("build day");
    // //print (currentDay.weekday.toString());
    //
    // while (currentDay.weekday > 5){
    //   currentDay.add(Duration(days:1));
    // }
    //
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
          padding: const EdgeInsets.all(5),
          child: Row (
            children : [ if (showArrows)
              IconButton(
              padding: const EdgeInsets.all(0),
              alignment: Alignment.centerRight,
              icon: (const Icon(Icons.keyboard_double_arrow_left)),
              color: Colors.black,
              onPressed: appState.moveRight,
            ),
          Spacer(),
          Text(DateFormat('EEEEE').format(currentDay),
              textAlign: TextAlign.center, style:const TextStyle(
    fontWeight: FontWeight.bold,
              fontSize: 20.0,
    ),),
              Spacer(),
              if (showArrows)
                IconButton(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.centerRight,
                  icon: (const Icon(Icons.keyboard_double_arrow_right)),
                  color: Colors.black,
                  onPressed: appState.moveLeft,
                ),
        ])),
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


