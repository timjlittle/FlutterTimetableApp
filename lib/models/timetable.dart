
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'group.dart';
import 'lesson.dart';
import 'package:path_provider/path_provider.dart';


/// Timetable class.
/// Contains information about the timetable such as number of lessons
/// plus serialisation
class TimetableModel with ChangeNotifier {
  int numPeriods = 6;
  bool isTwoWeek = false;
  bool dataRead = false;
  List <String> pNames = ["", "P1", "P2", "L", "P3", "P4", "P5"];

  List <LessonModel> mon = [];
  List <LessonModel> tue = [];
  List <LessonModel> wed = [];
  List <LessonModel> thu = [];
  List <LessonModel> fri = [];

  List <GroupModel> classes = [];


/*
Constructors
 */
  TimetableModel.named ({required this.numPeriods, required this.isTwoWeek, required this.pNames, required this.mon, required this.tue, required this.wed, required this.thu, required this.fri, required this.classes});

  TimetableModel () {
    numPeriods = 6;
    pNames = ["", "P1", "P2", "L", "P3", "P4", "P5"];
    mon = [];
    _initialiseToEmpty(mon, 1);
    tue = [];
    _initialiseToEmpty(tue, 2);
    wed = [];
    _initialiseToEmpty(wed, 3);
    thu = [];
    _initialiseToEmpty(thu, 4);
    fri = [];
    _initialiseToEmpty(fri, 5);
  }
  void setNumPeriods (int pNum){
    numPeriods = pNum;
    notifyListeners();
  }

void updateNumPeriods (int pNum){
    if (pNum != numPeriods) {
      //Need to reset the pNames

      int x = pNames.length;
      if (pNum > numPeriods){

        while (pNames.length < pNum + 1){
          pNames.add('P${x - 1}');
          x++;

          LessonModel lesson = LessonModel(1, x);
          mon.add(lesson);
          lesson = LessonModel(2, x);
          tue.add(lesson);
          lesson = LessonModel(3, x);
          wed.add(lesson);
          lesson = LessonModel(4, x);
          thu.add(lesson);
          lesson = LessonModel(5, x);
          fri.add(lesson);
        }
      } else {
        while (pNames.length > pNum + 1){
          pNames.removeAt(pNames.length - 1);
        }
      }


        numPeriods = pNum;
      notifyListeners();
    }
}

void setTwoWeek (bool pTwoWeek) {
    isTwoWeek = pTwoWeek;

    notifyListeners();
}

void setLessonDetails (int day, int lessNo, String subject, String classroom, String teacher) {

    switch (day){
      case 1:
        if (mon.isEmpty){
          _initialiseToEmpty(mon, 1);
        }
        mon.elementAt(lessNo).classId = subject;
        mon.elementAt(lessNo).teacher = teacher;
        mon.elementAt(lessNo).roomNo = classroom;
        break;

      case 2:
        if (tue.isEmpty){
          _initialiseToEmpty(tue, 2);
        }
        tue.elementAt(lessNo).classId = subject;
        tue.elementAt(lessNo).teacher = teacher;
        tue.elementAt(lessNo).roomNo = classroom;
        break;

      case 3:
        if (wed.isEmpty){
          _initialiseToEmpty(wed, 3);
        }
        wed.elementAt(lessNo).classId = subject;
        wed.elementAt(lessNo).teacher = teacher;
        wed.elementAt(lessNo).roomNo = classroom;
        break;

      case 4:
        if (thu.isEmpty){
          _initialiseToEmpty(thu, 4);
        }
        thu.elementAt(lessNo).classId = subject;
        thu.elementAt(lessNo).teacher = teacher;
        thu.elementAt(lessNo).roomNo = classroom;
        break;

      case 5:
        if (fri.isEmpty){
          _initialiseToEmpty(fri, 5);
        }
        fri.elementAt(lessNo).classId = subject;
        fri.elementAt(lessNo).teacher = teacher;
        fri.elementAt(lessNo).roomNo = classroom;
        break;

    }

    notifyListeners();
}

String getLessonSubject (int day, int lessNo) {
    String lesson = "";

    switch (day){
      case 1:
        if (mon.isEmpty){
          _initialiseToEmpty(mon, 1);
        }
        lesson = mon.elementAt(lessNo).classId;
        break;

      case 2:
        if (tue.isEmpty){
          _initialiseToEmpty(tue, 2);
        }
        lesson = tue.elementAt(lessNo).classId;
        break;

      case 3:
        if (wed.isEmpty){
          _initialiseToEmpty(wed, 3);
        }
        lesson = wed.elementAt(lessNo).classId;
        break;

      case 4:
        if (thu.isEmpty){
          _initialiseToEmpty(thu, 4);
        }
        lesson = thu.elementAt(lessNo).classId;
        break;

      case 5:
        if (fri.isEmpty){
          _initialiseToEmpty(fri, 5);
        }
        lesson = fri.elementAt(lessNo).classId;
        break;

    }

    return lesson;
}

  Color getLessonBackgroundColor (int day, int lessNo) {
    Color bg = const Color(0xffffffff);;

    switch (day){
      case 1:
        if (mon.isEmpty){
          _initialiseToEmpty(mon, 1);
        }
        bg = mon.elementAt(lessNo).bgColour;
        break;

      case 2:
        if (tue.isEmpty){
          _initialiseToEmpty(tue, 2);
        }
        bg = tue.elementAt(lessNo).bgColour;
        break;

      case 3:
        if (wed.isEmpty){
          _initialiseToEmpty(wed, 3);
        }
        bg = wed.elementAt(lessNo).bgColour;
        break;

      case 4:
        if (thu.isEmpty){
          _initialiseToEmpty(thu, 4);
        }
        bg = thu.elementAt(lessNo).bgColour;
        break;

      case 5:
        if (fri.isEmpty){
          _initialiseToEmpty(fri, 5);
        }
        bg = fri.elementAt(lessNo).bgColour;
        break;

    }

    return bg;
  }

  void setLessonBGColor (int day, int lessNo, Color bgColor){
    switch (day) {
      case 1:
        if (mon.isEmpty){
          _initialiseToEmpty(mon, 1);
        }
        mon.elementAt(lessNo).bgColour = bgColor;
        break;

      case 2:
        if (tue.isEmpty){
          _initialiseToEmpty(tue, 1);
        }
        tue.elementAt(lessNo).bgColour = bgColor;
        break;

      case 3:
        if (wed.isEmpty){
          _initialiseToEmpty(wed, 1);
        }
        wed.elementAt(lessNo).bgColour = bgColor;
        break;

      case 4:
        if (thu.isEmpty){
          _initialiseToEmpty(thu, 1);
        }
        thu.elementAt(lessNo).bgColour = bgColor;
        break;

      case 5:
        if (fri.isEmpty){
          _initialiseToEmpty(fri, 1);
        }
        fri.elementAt(lessNo).bgColour = bgColor;
        break;



    }

  }

  String getLessonkey (int day, int lessNo) {
    String lesson = "";

    switch (day){
      case 1:
        if (mon.isEmpty){
          _initialiseToEmpty(mon, 1);
        }
        lesson = mon.elementAt(lessNo).key;
        break;

      case 2:
        if (tue.isEmpty){
          _initialiseToEmpty(tue, 2);
        }
        lesson = tue.elementAt(lessNo).key;
        break;

      case 3:
        if (wed.isEmpty){
          _initialiseToEmpty(wed, 3);
        }
        lesson = wed.elementAt(lessNo).key;
        break;

      case 4:
        if (thu.isEmpty){
          _initialiseToEmpty(thu, 4);
        }
        lesson = thu.elementAt(lessNo).key;
        break;

      case 5:
        if (fri.isEmpty){
          _initialiseToEmpty(fri, 5);
        }
        lesson = fri.elementAt(lessNo).key;
        break;

    }

    return lesson;
  }

String getLessonRoom (int day, int lessNo) {
    String room = "";

    switch (day){
      case 1:
        if (mon.isEmpty){
          _initialiseToEmpty(mon, 1);
        }
        room = mon.elementAt(lessNo).roomNo;
        break;

      case 2:
        if (tue.isEmpty){
          _initialiseToEmpty(tue, 2);
        }
        room = tue.elementAt(lessNo).roomNo;
        break;

      case 3:
        if (wed.isEmpty){
          _initialiseToEmpty(wed, 3);
        }
        room = wed.elementAt(lessNo).roomNo;
        break;

      case 4:
        if (thu.isEmpty){
          _initialiseToEmpty(thu, 4);
        }
        room = thu.elementAt(lessNo).roomNo;
        break;

      case 5:
        if (fri.isEmpty){
          _initialiseToEmpty(fri, 5);
        }
        room = fri.elementAt(lessNo).roomNo;
        break;

    }

    return room;
  }

  String getLessonTeacher (int day, int lessNo) {
    String teacher = "";

    switch (day){
      case 1:
        if (mon.isEmpty){
          _initialiseToEmpty(mon, 1);
        }
        teacher = mon.elementAt(lessNo).teacher;
        break;

      case 2:
        if (tue.isEmpty){
          _initialiseToEmpty(tue, 2);
        }
        teacher = tue.elementAt(lessNo).teacher;
        break;

      case 3:
        if (wed.isEmpty){
          _initialiseToEmpty(wed, 3);
        }
        teacher = wed.elementAt(lessNo).teacher;
        break;

      case 4:
        if (thu.isEmpty){
          _initialiseToEmpty(thu, 4);
        }
        teacher = thu.elementAt(lessNo).teacher;
        break;

      case 5:
        if (fri.isEmpty){
          _initialiseToEmpty(fri, 5);
        }
        teacher = fri.elementAt(lessNo).teacher;
        break;

    }

    return teacher;
  }

  String getLessonName (int lessNo) {
    String name = "";

    name = pNames[lessNo + 1];

    return name;
  }

  List <GroupModel> getClasses (){
    return classes;
  }


  /*
  Serialisation
   */

  String buildField (String key, String val, bool isString){
    String field = "\"$key\":";

    if (isString) {
      field += jsonEncode(val);
    } else {
      field += val;
    }


    return field;
  }

  String jsonArrayOfLessons (List<LessonModel> dayList){
    String vals = "[";

    int c = 1;
    for (LessonModel l in dayList){
      vals += l.toJSON();
      if (c < dayList.length) {
        vals += ",";
      }
      c++;
    }

    //Replace the last comma with the closing ]
    //vals = vals.substring(0,vals.length - 1) + "]";
    vals = "$vals]";

    return vals;
  }

  String jsonArrayOfClasses (List<GroupModel> classList){
    String vals = "[";

    int c = 1;
    for (GroupModel l in classList){
      vals += l.toJSON();
      if (c < classList.length) {
        vals += ",";
      }
      c++;
    }

    //Replace the last comma with the closing ]
    //vals = vals.substring(0,vals.length - 1) + "]";
    vals = "$vals]";

    return vals;
  }


  String toJSON () {
    String ret = "{";
    String nameArray = "[";

    ret += buildField("numPeriods", numPeriods.toString(), false);
    ret += ", ";
    ret += buildField("isTwoWeek", isTwoWeek.toString(), false);
    ret += ", ";

    for (int x = 0; x<= numPeriods; x++){
      nameArray += jsonEncode(pNames[x]);

      if (x < numPeriods){
        nameArray += ",";
      }

    }

    nameArray += "]";

    ret += buildField ("pNames", nameArray, false);
    ret += ", ";

    ret += "${buildField("mon", jsonArrayOfLessons(mon) , false)},";
    ret += "${buildField("tue", jsonArrayOfLessons(tue) , false)},";
    ret += "${buildField("wed", jsonArrayOfLessons(wed) , false)},";
    ret += "${buildField("thu", jsonArrayOfLessons(thu) , false)},";
    ret += "${buildField("fri", jsonArrayOfLessons(fri) , false)},";

    ret += buildField("classes,", jsonArrayOfClasses(classes), false );

    ret += "}";


    return ret;
  }

  factory TimetableModel.fromJson(Map<String, dynamic> data) {
    final numPeriods = data["numPeriods"] as int;
    final pNames = data["pNames"] as List<String>;
    bool twoWeek = false;

    if (data.containsKey("isTwoWeek")){
      twoWeek = data["isTwoWeek"] as bool;
    }

    final monData = data['mon'] as List<dynamic>;
    final mon = monData.map((monData) => LessonModel.fromJson(monData)).toList();

    final tueData = data['tue'] as List<dynamic>;
    final tue = tueData.map((tueData) => LessonModel.fromJson(tueData)).toList();

    final wedData = data['wed'] as List<dynamic>;
    final wed = wedData.map((wedData) => LessonModel.fromJson(wedData)).toList();

    final thuData = data['thu'] as List<dynamic>;
    final thu = thuData.map((thuData) => LessonModel.fromJson(thuData)).toList();

    final friData = data['fri'] as List<dynamic>;
    final fri = friData.map((friData) => LessonModel.fromJson(friData)).toList();

    final classData = data['classes'] as List<dynamic>;
    final classes = classData.map((classData) => GroupModel.fromJson(classData)).toList();

    return TimetableModel.named (
        numPeriods : numPeriods,
        isTwoWeek : twoWeek,
        pNames : pNames,
        mon : mon,
        tue : tue,
        wed : wed,
        thu : thu,
        fri : fri,
        classes : classes
    );
  }

  _initialiseToEmpty (List<LessonModel> dayList, int day){
    for (int period = 1; period <= numPeriods; period++){
      LessonModel lesson = LessonModel(day, period);

      if (pNames.length == numPeriods + 1){
        lesson.lessonName = pNames[period];
      } else {
        lesson.lessonName = 'P$period';
      }

      dayList.add(lesson);
    }
  }

  List<LessonModel> getDay (int pDay){
    List ret = <LessonModel>[];
    String key;

    switch (pDay) {
      case 1:
        if (mon.isEmpty){
          _initialiseToEmpty(mon, 1);
        }
        return mon;
        break;

      case 2:
        if (tue.isEmpty){
          _initialiseToEmpty(tue, 2);
        }
        return tue;
        break;

      case 3:
        if (wed.isEmpty){
          _initialiseToEmpty(wed, 3);
        }
        return wed;
        break;

      case 4:
        if (thu.isEmpty){
          _initialiseToEmpty(thu, 4);
        }
        return thu;
        break;

      case 5:
        if (fri.isEmpty){
          _initialiseToEmpty(fri, 5);
        }
        return fri;
        break;

      default:
        List<LessonModel> dummy = [];
        return dummy;
        break;

    }
  }

  Future<String> get _localPath async {
    if (!kIsWeb) {
      final directory = await getApplicationDocumentsDirectory();

      return directory.path;
    } else {
      return "";
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    //print ('$path/timetable.JSON');
    return File('$path/timetable.JSON');
  }

  Future<String> _readJSON() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = file.readAsString();

      return contents;
    } catch (e) {
      print ("Error reading: $e");
      // If encountering an error, return 0
      return "";
    }
  }

  Future <void> readTimeTable () async {

    String data = await _readJSON();

    if (data.isNotEmpty) {

      //print(data);

      Map<String, dynamic> jsonMap = jsonDecode (data);

      isTwoWeek = jsonMap["isTwoWeek"] as bool;

      numPeriods = jsonMap["numPeriods"] as int;
      final dayData = jsonMap["pNames"] as List<dynamic>;
      pNames = List<String>.from(dayData);

      final monData = jsonMap['mon'] as List<dynamic>;
      mon = monData.map((monData) => LessonModel.fromJson(monData)).toList();

      final tueData = jsonMap['tue'] as List<dynamic>;
      tue = tueData.map((tueData) => LessonModel.fromJson(tueData)).toList();

      final wedData = jsonMap['wed'] as List<dynamic>;
      wed = wedData.map((wedData) => LessonModel.fromJson(wedData)).toList();

      final thuData = jsonMap['thu'] as List<dynamic>;
      thu = thuData.map((thuData) => LessonModel.fromJson(thuData)).toList();

      final friData = jsonMap['fri'] as List<dynamic>;
      fri = friData.map((friData) => LessonModel.fromJson(friData)).toList();

      if (jsonMap.containsKey('classes')) {
        final classData = jsonMap['classes'] as List<dynamic>;
        classes = classData.map((classData) =>
            GroupModel.fromJson(classData)).toList();
      } else {
        classes = [];
      }

    }
    dataRead = true;

    notifyListeners();
  }

  void writeJSON(String json) async {
    try {
      final file = await _localFile;

      // Write the file
      file.writeAsString(json);
    } catch (e) {
      print ("Error writing: $e");
    }
  }

  void save () {

    writeJSON (toJSON());

  }

}