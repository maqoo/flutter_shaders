import 'dart:ui' as ui;

import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BlurringPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BlurringPageState();
}

class BlurringPageState extends State<BlurringPage> {
  Widget get _background => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.limeAccent,
              Colors.deepOrangeAccent,
              Colors.blue,
              Colors.green
            ],
          ),
        ),
      );

  Widget _listElement(int index, {double height = 40}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: height,
            ),
            Center(
              child: ClipRect(
                child: BackdropFilter(
                  key: Key('$index'),
                  filter: ui.ImageFilter.matrix(vector.Matrix4.diagonal3(vector.Vector3.all(index * 0.1)).storage),
                  child: Container(
                    height: height,
                    color: Colors.grey.shade200.withOpacity(0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget get _listView => ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return _listElement(index);
        },
      );

  Widget get _list => NotificationListener(
        onNotification: (Notification notification) {
          if (notification is ScrollUpdateNotification) {
            setState(() {});
          }

          return true;
        },
        child: _listView,
      );

  Widget get _text => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      style: Theme.of(context).textTheme.title,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blurring'),
      ),
      body: Stack(
        children: <Widget>[
          _background,
          _text,
          _list,
        ],
      ),
    );
  }
}
