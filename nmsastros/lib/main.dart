import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nmsastros/screens/nmsastros_add_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter - @nmsastros - CRUD',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': ((context) => const NmsastrosAddScreen()),
      },
    );
  }
}
