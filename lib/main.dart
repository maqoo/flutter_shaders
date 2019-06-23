import 'package:flutter/material.dart';
import 'package:flutter_shaders/blurring.dart';
import 'package:flutter_shaders/masking.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Shaders'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buttonWithTitle(context, title: 'Blurring', onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => BlurringPage()));
            }),
            const SizedBox(height: 16),
            _buttonWithTitle(context, title: 'Masking', onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MaskingPage()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buttonWithTitle(BuildContext context,
          {String title, VoidCallback onTap}) =>
      Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 160,
            padding: const EdgeInsets.all(8),
            child: Text(title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.button),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              border: Border.all(
                  color: Theme.of(context).textTheme.button.color, width: 1),
            ),
          ),
        ),
      );
}
