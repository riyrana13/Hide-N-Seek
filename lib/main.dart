import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(HideNSeekApp());

class HideNSeekApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hide N Seek',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HomeScreen(),
    );
  }
}
