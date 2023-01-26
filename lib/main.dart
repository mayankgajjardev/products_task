import 'package:flutter/material.dart';
import 'package:product_task/modules/home/view/screen_home.dart';
import 'package:product_task/services/sql_light_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlightService.db();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prodcut Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreenHome(),
    );
  }
}
