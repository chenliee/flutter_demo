import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ColoredBox extends SingleChildRenderObjectWidget {
  final Color color;

  const ColoredBox({Key? key, this.color = Colors.blue, Widget? child})
      : super(key: key, child: child);

  @override
  RenderColoredBox createRenderObject(BuildContext context) {
    return RenderColoredBox(color: color);
  }

  @override
  void updateRenderObject(BuildContext context, RenderColoredBox renderObject) {
    renderObject.color = color;
  }
}

class RenderColoredBox extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  RenderColoredBox({required Color color}) : _color = color;

  Color get color => _color;
  Color _color;

  set color(Color value) {
    if (_color == value) {
      return;
    }
    _color = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    print(child);
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child!.size);
    } else {
      size = constraints.biggest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Paint paint = Paint()..color = color;
    context.canvas.drawRect(offset & size, paint);
    super.paint(context, offset);
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }
}
