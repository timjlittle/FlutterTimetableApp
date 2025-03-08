import 'dart:convert';
import 'dart:ui';
import 'package:material_color_utilities/material_color_utilities.dart';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';




/// Basic Lesson class.
/// Defaults to a Free but can be created from JSON
class LessonModel with ChangeNotifier {
  String _lessonName = "";
  String _classId = "";
  String _teacher = "";
  String _roomNo = "";
  int _day = 0;
  int _period = 0;
  int _grade = 7;
  late String _key;
  Color _bgColour = const Color(0xffffffff);
  Color _fgColour = const Color(0xff000000);



  LessonModel (int dayNum, int periodNum) {
    day = dayNum;
    period = periodNum;

    key = "${day}_$period";

  }


  /// Json builder

  factory LessonModel.fromJson(Map<String, dynamic> data) {
    final lessonName = data["lessonName"] as String;
    final classId = data["classId"] as String;
    final teacher = data["teacher"] as String;
    final roomNo = data["roomNo"] as String;
    final day = data["day"] as int;
    final period = data["period"] as int;
    int lgrade = 12;
    if (data.containsKey("grade")) {
      lgrade = data["grade"] as int;
    }
    final grade = lgrade;

    final key = data["key"] as String;

    LessonModel lm = LessonModel (day, period);
    lm.classId = classId;
    lm.teacher = teacher;
    lm.roomNo = roomNo;
    lm.lessonName = lessonName;
    lm.key = key;
    lm.grade = grade;

    if (data.containsKey("bgColour")) {
      final int bgColour = data["bgColour"] as int;
      final int fgColour = data["fgColour"] as int;
      lm.bgColour = Color (bgColour);
      lm.fgColour = Color (fgColour);;
    } else {
      lm.bgColour = const Color(0xffffffff);
      lm.fgColour = const Color(0xff000000);
    }

    return (lm);

  }


  String toJSON () {

    String ret = "{\"lessonName\" : ${jsonEncode (lessonName)}, \"classId\":${jsonEncode (classId)}, \"teacher\":${jsonEncode (teacher)},\"roomNo\" : ${jsonEncode (roomNo)},\"day\" : $day, \"period\":$period, \"grade\":$grade, \"key\": ${jsonEncode(key)}, \"bgColour\" : ${jsonEncode (bgColour.toARGB32() )}, \"fgColour\" : ${jsonEncode (fgColour.toARGB32())} }";

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

  int get grade => _grade;

  set grade(int value) {
    _grade = value;
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

  Color get bgColour => _bgColour;
  Color get fgColour => _fgColour;

  set bgColour (Color value) {
    _bgColour = value;
    notifyListeners();
  }

  set fgColour (Color value) {
    _fgColour = value;
    notifyListeners();
  }
}
