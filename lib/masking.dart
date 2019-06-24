import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_shaders/mask_painting.dart';

class MaskingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MaskingPageState();
}

class MaskingPageState extends State<MaskingPage> {
  Widget get _background => Container(
        width: 400,
        height: 400,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<ui.Image>(
              future: _getAssetImage('assets/images/mask.png'),
              builder:
                  (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return MaskPainting(_background, image: snapshot.data);
                    default:
                      return SizedBox.shrink();
                  }
                }

                return SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<ui.Image> _getAssetImage(String assetPath) {
    Completer<ui.Image> completer = new Completer<ui.Image>();

    new AssetImage(assetPath).resolve(new ImageConfiguration()).addListener(
        ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image)));

    return completer.future;
  }
}
