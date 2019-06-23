import 'package:flutter/material.dart';

class MaskingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MaskingPageState();
}

class MaskingPageState extends State<MaskingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masking'),
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
