import 'dart:ui';
import 'dart:convert';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class GroupModel with ChangeNotifier {
  String _classId = "";
  String _subject = "";
  String _room = "";
  int _grade = 7;
  Color _bgColour = const Color(0xffffffff);
  Color _fgColour = const Color(0xff000000);

  GroupModel ();

  factory GroupModel.fromJson(Map<String, dynamic> data){
    final String classId = data["classId"] as String;
    final String subject = data["subject"] as String;
    final String room = data["room"] as String;
    final int grade = data["grade"] as int;
    final String bgColour = data["bgColour"] as String;
    final String fgColour = data["fgColour"] as String;

    GroupModel g = GroupModel ();

    g.classId = classId;
    g.subject = subject;
    g.room = room;
    g.grade = grade;
    g.bgColour = Color (int.parse(bgColour));
    g.fgColour = Color (int.parse(fgColour));

    return g;
  }

    String get classId => _classId;
    String get subject => _subject;
    String get room => _room;
    int get grade => _grade;
    Color get bgColour => _bgColour;
    Color get fgColour => _fgColour;

    set classId (String value) {
      _classId = value;
      notifyListeners();
  }

  set subject (String value) {
    _subject = value;
    notifyListeners();
  }

  set room (String value) {
    _room = value;
    notifyListeners();
  }

  set grade (int value) {
    _grade = value;
    notifyListeners();
  }

  set bgColour (Color value) {
    _bgColour = value;
    notifyListeners();
  }

  set fgColour (Color value) {
    _fgColour = value;
    notifyListeners();
  }

  String toJSON () {

      String ret = "{\"classId\" : ${jsonEncode (classId)}, \"subject\" : ${jsonEncode (classId)}, \"subject\" : ${jsonEncode (classId)}, \"room\" : ${jsonEncode (room)}, \"grade\" : ${jsonEncode (grade)}, \"bgColour\" : ${jsonEncode (bgColour)}, \"fgColour\" : ${jsonEncode (fgColour)}";

      return ret;

  }

}