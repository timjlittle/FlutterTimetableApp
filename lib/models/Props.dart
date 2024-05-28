import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Props {

}

class Prop {
  final String key;
  final String value;

  const Prop ({required this.key, required this.value});

  Map <String, dynamic> toMap () {
    return {'key': key,
      'value': value,};
  }

}