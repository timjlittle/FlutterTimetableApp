import 'dart:convert';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/**
 * Basic Lesson class.
 * Defaults to a Free but can be created from JSON
 */
class LessonModel with ChangeNotifier {
  String _lessonName = "";
  String _classId = "";
  String _teacher = "";
  String _roomNo = "";
  int _day = 0;
  int _period = 0;
  late String _key;



  LessonModel (int dayNum, int periodNum) {
    day = dayNum;
    period = periodNum;

    key = day.toString() + "_" + period.toString();

  }


  /**
   * Json builder
   */

  factory LessonModel.fromJson(Map<String, dynamic> data) {
    final lessonName = data["lessonName"] as String;
    final classId = data["classId"] as String;
    final teacher = data["teacher"] as String;
    final roomNo = data["roomNo"] as String;
    final day = data["day"] as int;
    final period = data["period"] as int;
    final key = data["key"] as String;

    LessonModel lm = LessonModel (day, period);
    lm.classId = classId;
    lm.teacher = teacher;
    lm.roomNo = roomNo;
    lm.lessonName = lessonName;
    lm.key = key;

    return (lm);

  }


  String toJSON () {

    String ret = "{\"lessonName\" : " + jsonEncode (lessonName) + ", " +
        "\"classId\":"+ jsonEncode (classId) +
        ", \"teacher\":"+jsonEncode (teacher) +
        ",\"roomNo\" : " + jsonEncode (roomNo) +
        ",\"day\" : " + day.toString() +
        ", \"period\":" + period.toString() +
        ", \"key\": " + jsonEncode(key)  +
        " }";

    return ret;
  }

  int get period => _period;

  set period(int value) {
    _period = value;
    notifyListeners();
  }

  int get day => _day;

  set day(int value) {
    _day = value;
    notifyListeners();
  }

  String get roomNo => _roomNo;

  set roomNo(String value) {
    _roomNo = value;
    notifyListeners();
  }

  String get teacher => _teacher;

  set teacher(String value) {
    _teacher = value;
    notifyListeners();
  }

  String get classId => _classId;

  set classId(String value) {
    _classId = value;
    notifyListeners();
  }

  String get lessonName => _lessonName;

  set lessonName(String value) {
    _lessonName = value;
    notifyListeners();
  }

  String get key => _key;

  set key(String value) {
    _key = value;
    notifyListeners();
  }
}
