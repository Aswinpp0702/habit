import 'package:flutter/material.dart';
import 'package:habit_tracker/screens/read_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'model/model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DataAdapter());
  // Hive.registerAdapter(DataAdapter());
  await Hive.openBox('data_box');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Read_screen(),
    );
  }
}

