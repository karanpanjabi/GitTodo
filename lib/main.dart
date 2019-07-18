import 'package:flutter/material.dart';
import 'package:git_todo/routes/repos.dart';
import 'package:git_todo/routes/todos.dart';
import 'package:git_todo/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitTodo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/account': (context) => ReposScreen(),
        '/todos': (context) => TodoScreen(),
        '/test': (context) {
          return Scaffold(
            appBar: AppBar(title: Text('Test')),
          );
         },
      },
    );
  }
}
