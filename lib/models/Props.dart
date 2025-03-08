import 'package:shared_preferences/shared_preferences.dart';

class Props {
  bool _twoWeek = false;
  int _termCount = 6;
  bool _showGrade = false;
  bool _showRoom = true;

  Future<void> readPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _twoWeek = prefs.getBool('isTwoWeeks') ?? false;
    _termCount = prefs.getInt('termCount') ??6;
    _showGrade = prefs.getBool('showGrade') ?? false;
    _showRoom = prefs.getBool('showRoom') ?? true;

  }

  bool isTwoWeek ()  => _twoWeek;
  int termCount() => _termCount;
  bool showGrade() => _showGrade;
  bool showRoom() => _showRoom;

  Future<void> setTwoWeek (bool twoWeeks) async {
    _twoWeek = twoWeeks;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isTwoWeeks', twoWeeks);
  }

  Future<void> setTermCount (int termCount) async {
    _termCount = termCount;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isTwoWeeks', termCount);
  }

  Future<void> setShowGrade (bool showGrade) async {
    _showGrade = showGrade;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showGrade', showGrade);
  }

  Future<void> setShowRoom (bool showRoom) async {
    _showRoom = showRoom;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showRoom', showRoom);
  }


}