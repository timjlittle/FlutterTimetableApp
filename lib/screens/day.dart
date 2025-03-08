
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt2/models/timetable.dart';
import 'package:tt2/main.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';



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

     saveFunction ("X");
  }

  _localDiscardPressed() {

    timetable.readTimeTable();
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
                      child: Text(timetable.getLessonName(lessNo)),
                    ),
                    const Spacer(),
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
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _subject,
                    autocorrect: false,
                    enabled: true,
                    decoration: const InputDecoration(hintText: 'Subject/Class name'),
                  )
              ),

              Container(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: classroom,
                    autocorrect: false,
                    decoration: const InputDecoration(hintText: 'Classroom'),
                  )
              ),

              Container(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: teacher,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        hintText: 'Teacher'),
                  )
              ),

              Container(
                  padding: const EdgeInsets.all(10.0),

                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: timetable.getLessonBackgroundColor(dayNo, lessNo),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        foregroundColor: Colors.black,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: MaterialPicker(
                                  pickerColor: timetable.getLessonBackgroundColor(dayNo, lessNo), //default color
                                  onColorChanged: (Color color) {
                                    //on color picked
                                    timetable.setLessonBGColor(dayNo, lessNo, color);

                                  },
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('DONE'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); //dismiss the color picker
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: const Text("BG Colour"),
                  )
              ),


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
    padding: const EdgeInsets.all(1.0),
    child : GestureDetector(
      onLongPress: _localEditClick,
      child:Container(
      decoration: BoxDecoration(
        color: timetable.getLessonBackgroundColor(dayNum, lessNo ),
          border: Border.all(
            width: 1,
            color: Colors.black
        ),
            borderRadius: BorderRadius.circular(10)
        ),

      child: ListTile(
    leading: CircleAvatar(
    backgroundColor: Colors.lightBlueAccent.shade400,
      child: Text(timetable.getLessonName(lessNo)),
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

  DayPage ({super.key, required this.currentDay, required this.showArrows});

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
          const Spacer(),
          Text(DateFormat('EEEEE').format(currentDay),
              textAlign: TextAlign.center, style:const TextStyle(
    fontWeight: FontWeight.bold,
              fontSize: 20.0,
    ),),
              const Spacer(),
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


