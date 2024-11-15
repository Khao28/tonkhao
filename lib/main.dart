import 'package:flutter/material.dart';
import 'package:tonkhao/widgets/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
await dotenv.load(fileName: ".env.flutter");
  runApp(
    MaterialApp(
      home: LoginScreen(),
    ),
  );
}
