import 'package:flutter/material.dart';

class BlurringPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BlurringPageState();
}

class BlurringPageState extends State<BlurringPage> {
  Widget get _background => Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 0.8,
            colors: <Color>[Colors.limeAccent, Colors.deepOrangeAccent],
          ),
        ),
      );

  Widget get _list => ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: 100,
                height: 28,
                color: Colors.red),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blurring'),
      ),
      body: Stack(
        children: <Widget>[_background, _list],
      ),
    );
  }
}
