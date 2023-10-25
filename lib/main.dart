import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tt2/common/theme.dart';
import 'package:tt2/models/timetable.dart';
import 'package:tt2/models/lesson.dart';
import 'package:tt2/screens/day.dart';
import 'package:tt2/screens/week.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';





class MyAppState extends ChangeNotifier {

  //TimetableModel timetable = TimetableModel(numPeriods:6, pNames:["", "P1", "P2", "L", "P3", "P4", "P5"], mon:[], tue:[], wed:[], thu:[], fri:[]);
  //TimetableModel timetable = new TimetableModel();
  DateTime currentDay = DateTime.now();
  String toEdit = "";

  MyAppState () {

    //timetable.readTimeTable();

    while (currentDay.weekday > 5) {
      currentDay = currentDay.add(const Duration(days: 1));
    }
    //notifyListeners();

  }

  void handleEditClick (String key) {
    toEdit = key;

    // if (key == "") {
    //   timetable.save();
    // }
    notifyListeners();
  }


  void moveLeft (){
    currentDay = currentDay.add(const Duration(days: 1));
    if (currentDay.weekday == 6){
      currentDay = currentDay.add(const Duration(days: 2));
    }

    notifyListeners();
  }

  void moveRight () {
    currentDay = currentDay.add(const Duration(days: -1));
    if (currentDay.weekday == 7){
      currentDay = currentDay.add(const Duration(days: -2));
    }
    notifyListeners();
  }

  void handleSwipe (DragEndDetails details){

    //print("Swiped");

      if (details.primaryVelocity! < 0) {
        moveLeft();

        //print ("right: " + currentDay.weekday.toString());
      } else if (details.primaryVelocity! > 0) {
        moveRight();

        //print ("left: " + currentDay.weekday.toString());
      } else {
        //print ("not moved");
      }

      //notifyListeners();
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  print ('$path/timetable.JSON');
  return File('$path/timetable.JSON');
}

Future<String> readJSON() async {
  try {
    final file = await _localFile;

    if (await file.exists()){

    // Read the file
    final contents = await file.readAsString ();

    return contents;
  } else {
      return ("");
  }

  } catch (e) {
    print ("Error reading JSON: " + e.toString());
    // If encountering an error, return 0
    return "";
  }
}
void main() async {

  runApp(
    ChangeNotifierProvider(
      create: (_) => TimetableModel(),
      child: MyApp(),
    ),
  );
}

const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    TimetableModel timetable = Provider.of<TimetableModel>(context);

    if (!timetable.dataRead) {
      timetable.readTimeTable();
    }

    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Time Table',
        theme: ThemeData(
          useMaterial3: true,
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }

}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    bool isPortrait = false;

    double width = MediaQuery.of(context).size.width;

    isPortrait = width < 700;

    DateTime currentDay = appState.currentDay;

    if (!isPortrait) {
      while (currentDay.weekday > 1) {
        currentDay = currentDay.subtract(Duration(days: 1));
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tim\'s Timetable App'),
        ),
        body: Center(
            child: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details){appState.handleSwipe(details);},
                child: WeekPage() //currentDay: currentDay

            )

        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tim\'s Timetable App'),
        ),
        body: Center(

              child:DayPage(currentDay: currentDay, showArrows:true)


        ),
      );
    }


  }
}

