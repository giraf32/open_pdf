import 'package:flutter/material.dart';

class InfoApp extends StatelessWidget {
  const InfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.cyanAccent,
        body: Center(
      child: Container(
          decoration: BoxDecoration(
              //color: theme.canvasColor,
              //Theme.of(context).cardColor,
              border: Border.all(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.circular(18.0)),
          height: 400,
          width: 300,
          child: Center(
              child: Text('Info'),


          )),
    ));
  }
}
