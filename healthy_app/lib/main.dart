import 'package:flutter/material.dart';
import 'package:healthy_app/screens/wrapper.dart';

void main() {
  runApp(myApp());
}
class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}

