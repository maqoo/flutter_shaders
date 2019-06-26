import 'package:flutter/material.dart';
import 'package:flutter_shaders/list.dart';

class MaskingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MaskingPageState();
}

class MaskingPageState extends State<MaskingPage> {
  Widget get _background => Container(
        constraints: BoxConstraints.expand(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masking'),
      ),
      body: Stack(
        children: <Widget>[_background, _stickyHeaderMaskedList(context)],
      ),
    );
  }

  Widget _stickyHeaderMaskedList(BuildContext context) =>
      StickyHeaderMaskedList(
        sectionCount: 10,
        sectionHeaderBuilder: (BuildContext context, int sectionIndex) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Header $sectionIndex'),
            ),
          );
        },
        elementBuilder:
            (BuildContext context, int sectionIndex, int elementIndex) {
          return ClipPath(
            clipper: Clipper(),
            child: Container(
              color: Colors.cyan,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Item $elementIndex',
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
            ),
          );
        },
        sectionItemsCountHandler: (int _) => 5,
      );
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
//    path.addRect(Rect.fromLTWH(10, 10, size.width - 20, size.height - 20));
    path.addOval(Rect.fromLTWH(10, 10, size.width - 20, size.height - 20));
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}