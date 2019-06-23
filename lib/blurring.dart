import 'package:flutter/material.dart';

class BlurringPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BlurringPageState();
}

class BlurringPageState extends State<BlurringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blurring'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}