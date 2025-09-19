import 'package:flutter/material.dart';
import 'screens/api_key_screen.dart';

void main() => runApp(IrisApp());

class IrisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Iris Predictor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: ApiKeyScreen(),
    );
  }
}