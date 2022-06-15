import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nmsastros/models/user/user_services.dart';
import 'package:nmsastros/screens/chart/chart_list_screen.dart';
import 'package:nmsastros/screens/login/login_screen.dart';
import 'package:nmsastros/screens/users/users_list_screen.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserServices(),
          //determina que a classe UserServices ainda não foi utilizada, portanto a instanciação será feita imediatamente
          lazy: true,
        ),
      ],
      child: MaterialApp(
        title: '@nmsastros',
        theme: ThemeData.dark(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/chart': (context) => const ChartListScreen(),
          '/users': (context) => const UsersListScreen(),
        },
      ),
    );
  }
}
