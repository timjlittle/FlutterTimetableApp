
import 'dart:convert';
import 'dart:io';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'lesson.dart';
import 'package:path_provider/path_provider.dart';


/**
 * Timetable class.
 * Contains information about the timetable such as number of lessons
 * plus serialisation
 */
class TimetableModel with ChangeNotifier {
  int numPeriods = 6;
  bool dataRead = false;
  List <String> pNames = ["", "P1", "P2", "L", "P3", "P4", "P5"];

  List <LessonModel> mon = [];
  List <LessonModel> tue = [];
  List <LessonModel> wed = [];
  List <LessonModel> thu = [];
  List <LessonModel> fri = [];


/*
Constructors
 */
  TimetableModel.named ({required this.numPeriods, required this.pNames, required this.mon, required this.tue, required this.wed, required this.thu, required this.fri});

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

  String getLessonName (int day, int lessNo) {
    String name = "";

    switch (day){
      case 1:
        if (mon.isEmpty){
          _initialiseToEmpty(mon, 1);
        }
        name = mon.elementAt(lessNo).lessonName;
        break;

      case 2:
        if (tue.isEmpty){
          _initialiseToEmpty(tue, 2);
        }
        name = tue.elementAt(lessNo).lessonName;
        break;

      case 3:
        if (wed.isEmpty){
          _initialiseToEmpty(wed, 3);
        }
        name = wed.elementAt(lessNo).lessonName;
        break;

      case 4:
        if (thu.isEmpty){
          _initialiseToEmpty(thu, 4);
        }
        name = thu.elementAt(lessNo).lessonName;
        break;

      case 5:
        if (fri.isEmpty){
          _initialiseToEmpty(fri, 5);
        }
        name = fri.elementAt(lessNo).lessonName;
        break;

    }

    return name;
  }


  /*
  Serialisation
   */

  String buildField (String key, String val, bool isString){
    String field = "\"" + key + "\":";

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
    vals = vals + "]";

    return vals;
  }


  String toJSON () {
    String ret = "{";
    String nameArray = "[";

    ret += buildField("numPeriods", numPeriods.toString(), false);
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

    ret += buildField("mon", jsonArrayOfLessons(mon) , false) + ",";
    ret += buildField("tue", jsonArrayOfLessons(tue) , false) + ",";
    ret += buildField("wed", jsonArrayOfLessons(wed) , false) + ",";
    ret += buildField("thu", jsonArrayOfLessons(thu) , false) + ",";
    ret += buildField("fri", jsonArrayOfLessons(fri) , false);

    ret += "}";


    return ret;
  }

  factory TimetableModel.fromJson(Map<String, dynamic> data) {
    final numPeriods = data["numPeriods"] as int;
    final pNames = data["pNames"] as List<String>;

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


    return TimetableModel.named (
        numPeriods : numPeriods,
        pNames : pNames,
        mon : mon,
        tue : tue,
        wed : wed,
        thu : thu,
        fri : fri
    );
  }

  _initialiseToEmpty (List<LessonModel> dayList, int day){
    for (int period = 1; period <= numPeriods; period++){
      LessonModel lesson = LessonModel(day, period);

      if (pNames.length == numPeriods + 1){
        lesson.lessonName = pNames[period];
      } else {
        lesson.lessonName = 'P' + period.toString();
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

    if (data.length > 0) {

      //print(data);

      Map<String, dynamic> jsonMap = jsonDecode (data);

      this.numPeriods = jsonMap["numPeriods"] as int;
      final dayData = jsonMap["pNames"] as List<dynamic>;
      this.pNames = List<String>.from(dayData);

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

    }
    this.dataRead = true;

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