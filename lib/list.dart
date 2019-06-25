import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sticky_headers/sticky_headers.dart';

typedef ListSectionHeaderBuilder = Widget Function(
    BuildContext context, int index);
typedef ListItemBuilder = Widget Function(
    BuildContext context, int sectionIndex, int itemIndex);
typedef ListSectionItemsCountHandler = int Function(int sectionIndex);
typedef ListSeparatorBuilder = Widget Function(
    BuildContext context, int sectionIndex);

class StickyHeaderMaskedList extends StatelessWidget {
  const StickyHeaderMaskedList(
      {@required int sectionCount,
      @required ListSectionHeaderBuilder sectionHeaderBuilder,
      @required ListItemBuilder elementBuilder,
      @required ListSectionItemsCountHandler sectionItemsCountHandler,
      EdgeInsets padding = EdgeInsets.zero})
      : assert(sectionHeaderBuilder != null),
        assert(sectionCount != null),
        assert(elementBuilder != null),
        assert(sectionItemsCountHandler != null),
        _sectionElementsCountHandler = sectionItemsCountHandler,
        _elementBuilder = elementBuilder,
        _sectionCount = sectionCount,
        _sectionHeaderBuilder = sectionHeaderBuilder,
        _padding = padding;

  final int _sectionCount;
  final ListSectionItemsCountHandler _sectionElementsCountHandler;
  final ListItemBuilder _elementBuilder;
  final ListSectionHeaderBuilder _sectionHeaderBuilder;
  final EdgeInsets _padding;

  @override
  Widget build(BuildContext context) => ListView.builder(
      padding: _padding, itemCount: _sectionCount, itemBuilder: _sectionHeader);

  StickyHeader _sectionHeader(BuildContext context, int sectionIndex) {
    final GlobalKey eventListHeaderKey = GlobalKey();
    final GlobalKey shaderMaskKey = GlobalKey();

    return StickyHeader(
        header: Container(
            key: eventListHeaderKey,
            child: _sectionHeaderBuilder(context, sectionIndex)),
        content: ShaderMask(
            key: shaderMaskKey,
            shaderCallback: (Rect rect) =>
                _listShader(eventListHeaderKey, shaderMaskKey, rect),
            blendMode: BlendMode.dstIn,
            child: Container(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _sectionElementsCountHandler(sectionIndex),
                    itemBuilder: (BuildContext context, int index) =>
                        _elementBuilder(context, sectionIndex, index)))));
  }

  Shader _listShader(
      GlobalKey listHeaderKey, GlobalKey shaderMaskKey, Rect rect) {
    final RenderBox listHeaderRenderBox =
        listHeaderKey.currentContext.findRenderObject();
    final Offset offset = listHeaderRenderBox.localToGlobal(Offset.zero);

    final RenderBox shaderMaskRenderBox =
        shaderMaskKey.currentContext.findRenderObject();
    final Offset offset2 = shaderMaskRenderBox.globalToLocal(offset);

    return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: <double>[
          0,
          (rect.top + offset2.dy) / rect.height,
          (rect.top + offset2.dy) / rect.height,
          1
        ],
        colors: <Color>[
          Colors.transparent,
          Colors.transparent,
          Colors.white,
          Colors.white
        ]).createShader(Rect.fromLTWH(0, 0, rect.width, rect.height));
  }
}
