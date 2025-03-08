import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tt2/models/timetable.dart';
import 'package:tt2/screens/configDay.dart';
import 'package:tt2/screens/day.dart';
import 'package:tt2/screens/week.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:path_provider/path_provider.dart';
//added for sqflite
import 'dart:async';


class MyAppState extends ChangeNotifier {

  //TimetableModel timetable = TimetableModel(numPeriods:6, pNames:["", "P1", "P2", "L", "P3", "P4", "P5"], mon:[], tue:[], wed:[], thu:[], fri:[]);
  //TimetableModel timetable = new TimetableModel();
  DateTime currentDay = DateTime.now();
  String toEdit = "";
  int pageChoice = 0;

  MyAppState () {

    //timetable.readTimeTable();

    while (currentDay.weekday > 5) {
      currentDay = currentDay.add(const Duration(days: 1));
    }
    //notifyListeners();

  }

  void choosePage (int choice){
    pageChoice = choice;
    notifyListeners();
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
  //print ('$path/timetable.JSON');
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
    print ("Error reading JSON: $e");
    // If encountering an error, return 0
    return "";
  }
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => TimetableModel(),
      child: const MyApp(),
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

    //TimetableModel timetable = Provider.of<TimetableModel>(context);
    TimetableModel timetable = context.watch<TimetableModel>();

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
        home: const MyHomePage(),
      ),
    );
  }

}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    bool isPortrait = false;

    double width = MediaQuery.of(context).size.width;

    isPortrait = width < 700;

    DateTime currentDay = appState.currentDay;
    int pageChoice = appState.pageChoice;

    void onItemTapped (int index){
        appState.choosePage(index);
    }

    StatelessWidget pageToShow = DayPage(currentDay: currentDay, showArrows:true);

    if (!isPortrait) {
      pageToShow = WeekPage();
      while (currentDay.weekday > 1) {
        currentDay = currentDay.subtract(const Duration(days: 1));
      }
    }

    if (pageChoice == 1){
      pageToShow = ConfigDay();
    }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Tim\'s Timetable App'),
        ),
        drawer: Drawer (
          child: ListView (
            padding: EdgeInsets.zero,
            children: [

              ListTile(
                title: const Text('Timetable'),
                onTap: () {
                  onItemTapped(0);
                  Navigator.pop (context);
                }
              ),
              ListTile(
                  title: const Text('Day Config'),
                  onTap: () {
                    onItemTapped(1);
                    Navigator.pop (context);
                  }
              ),
            ]
          )
        ),
        body: Center(
            child: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details){appState.handleSwipe(details);},
                child: pageToShow //WeekPage() //currentDay: currentDay

            )

        ),
      );
    }

  }


