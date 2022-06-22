// @dart=2.9
import 'package:flutter/material.dart';
import 'package:gomez_todo/src/scr/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('notes');
  await Hive.openBox('accounts');
  runApp(const MyApp());
}
