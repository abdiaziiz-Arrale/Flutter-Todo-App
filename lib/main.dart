import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/Counters.dart';
import 'package:todo_app/TodoList.dart';
import 'package:todo_app/todoScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
home: Tudo(),

    );
  }
}
