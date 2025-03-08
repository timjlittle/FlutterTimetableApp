import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt2/models/timetable.dart';
import 'package:tt2/main.dart';
//import 'package:numberpicker/numberpicker.dart';

class ConfigDay extends StatelessWidget with ChangeNotifier {
  final TextEditingController lessonCount = TextEditingController();
  late TimetableModel timetable;
  List<int> pCountList = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<TextEditingController> lessonNames = [];
  late ValueChanged<String> saveFunction;

  _localSavePressed() {
    for (int x = 0; x < timetable.numPeriods; x++) {
      timetable.pNames[x+1] = lessonNames[x].text;
    }
    timetable.save();
    saveFunction("");
  }

  _localDiscardPressed() {
    timetable.readTimeTable();
    saveFunction("");
  }

  ConfigDay({super.key});

  @override
  void dispose() {
    while (lessonNames.isNotEmpty) {
      TextEditingController ln = lessonNames.first;
      ln.dispose();
      lessonNames.remove(ln);
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    //timetable = Provider.of<TimetableModel>(context);
    timetable = context.watch<TimetableModel>();
    var appState = context.watch<MyAppState>();
    saveFunction = appState.handleEditClick;

    for (int x = 0; x < timetable.numPeriods; x++) {
      TextEditingController ln = TextEditingController();
      ln.text = timetable.pNames[x +1];
      lessonNames.add(ln);
    }

    return ListView(children: [
      Container(
          height: 56.0,
          decoration: BoxDecoration(
              color: Colors.blue[400],
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(5),
          child: Row(children: [
            const Spacer(),
            const Text("Configure Day",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
            const Spacer()
          ])),
      Row(children: [
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
      ]),
      ListTile(
          title: const Text('Two week timetable'),
          leading:
              Consumer<TimetableModel>(builder: (context, timetable, child) {
            return Checkbox(
                value: timetable.isTwoWeek,
                onChanged: (value) {
                  timetable.isTwoWeek = value!;
                  //timetable.save();

                  appState.handleEditClick("");
                });
          })),
      ListTile(
          title: const Text('Number of lessons per day'),
          leading:
              Consumer<TimetableModel>(builder: (context, timetable, child) {
            return DropdownMenu<int>(
              initialSelection: timetable.numPeriods,
              onSelected: (value) {
                if (value != null) {
                  timetable.updateNumPeriods(value);
                  //timetable.save();
                  appState.handleEditClick("");
                }
              },
              dropdownMenuEntries:
                  pCountList.map<DropdownMenuEntry<int>>((int value) {
                return DropdownMenuEntry<int>(value: value, label: '$value');
              }).toList(),
            );
          })),
      for (int x = 0; x < timetable.numPeriods; x++)
        Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: lessonNames[x],
              autocorrect: false,
            ))
    ]);
  }
}
