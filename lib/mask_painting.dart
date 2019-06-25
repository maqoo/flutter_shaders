import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as rendering;
import 'package:flutter/widgets.dart';

class MaskPainting extends SingleChildRenderObjectWidget {
  MaskPainting(Widget child, {this.image})
      : assert(child != null),
        super(child: child);

  final ui.Image image;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      MaskPaintingFilter(image);
}

class MaskPaintingFilter extends rendering.RenderProxyBox {
  MaskPaintingFilter(this.image)
      : _maskPaint = Paint()..blendMode = BlendMode.overlay;

  final Paint _clearPaint = Paint();
  final Paint _maskPaint;

  final ui.Image image;

  @override
  bool get alwaysNeedsCompositing => child != null;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    }

    final Rect rect = offset & child.size;
    _maskPaint.shader = ImageShader(
        image, TileMode.clamp, TileMode.clamp, Matrix4.identity().storage);

//    _maskPaint.shader = SweepGradient(
//            colors: <Color>[Colors.transparent, Colors.black],
//            tileMode: TileMode.repeated)
//        .createShader(rect);

    context.canvas.saveLayer(rect, _clearPaint);
    context.paintChild(child, offset);
//    context.canvas.scale(0.5, 0.5);
    context.canvas.drawRect(rect, _maskPaint);
    context.canvas.restore();
  }
}
