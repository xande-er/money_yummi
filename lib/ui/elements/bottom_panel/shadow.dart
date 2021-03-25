import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class GradientBorder extends StatelessWidget {
  final Widget child;
  final LinearGradient gradient;
  final BorderRadius radius;
  final double width;

  const GradientBorder({@required this.gradient, @required this.radius, @required this.width, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(gradient: gradient, borderRadius: radius),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(width),
          child: child,
        )
      ],
    );
  }
}

class BorderWidget extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final BorderRadius radius;
  final double width;

  const BorderWidget({@required this.borderColor, @required this.radius, @required this.width, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(color: borderColor, borderRadius: radius),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(width),
          child: child,
        )
      ],
    );
  }
}

class GradientPainter extends CustomPainter {
  final LinearGradient gradient;
  final Radius radius;
  final double strokeWidth;

  GradientPainter(this.gradient, this.radius, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, size.width - strokeWidth, size.height - strokeWidth);

    // final newGradient = LinearGradient(
    //   begin: gradient.begin,
    //   end: gradient.end,
    //   tileMode: gradient.tileMode,
    //   stops: gradient.stops,
    //   transform: gradient.transform,
    //   colors: gradient.colors.reversed.toList(),
    // );

    final rRect = RRect.fromRectAndRadius(rect, radius ?? Radius.zero);
    final _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect);
    canvas.drawRRect(rRect, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    Key key,
    this.color,
    this.blur,
    this.offset,
    Widget child,
  }) : super(key: key, child: child);

  final Color color;
  final double blur;
  final Offset offset;

  @override
  RenderInnerShadow createRenderObject(BuildContext context) {
    return RenderInnerShadow()
      ..color = color
      ..blur = blur
      ..offset = offset;
  }

  @override
  void updateRenderObject(BuildContext context, RenderInnerShadow renderObject) {
    renderObject
      ..color = color
      ..blur = blur
      ..offset = offset;
  }
}

class RenderInnerShadow extends RenderProxyBox {
  RenderInnerShadow({
    RenderBox child,
  }) : super(child);

  @override
  bool get alwaysNeedsCompositing => child != null;

  Color _color;
  double _blur;
  Offset _offset;

  Color get color => _color;

  set color(Color value) {
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  double get blur => _blur;

  set blur(double value) {
    if (_blur == value) return;
    _blur = value;
    markNeedsPaint();
  }

  Offset get offset => _offset;

  set offset(Offset value) {
    if (_offset == value) return;
    _offset = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final layerPaint = Paint()..color = Colors.white;

      context.canvas.saveLayer(offset & size, layerPaint);
      context.paintChild(child, offset);
      final shadowPaint = Paint()
        ..blendMode = ui.BlendMode.srcATop
        ..imageFilter = ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur)
        ..colorFilter = ui.ColorFilter.mode(color, ui.BlendMode.srcIn);
      context.canvas.saveLayer(offset & size, shadowPaint);

      // Invert the alpha to compute inner part.
      final invertPaint = Paint()
        ..colorFilter = const ui.ColorFilter.matrix([
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0,
          -1,
          255,
        ]);
      context.canvas.saveLayer(offset & size, invertPaint);
      context.canvas.translate(_offset.dx, _offset.dy);
      context.paintChild(child, offset);
      context.canvas.restore();
      context.canvas.restore();
      context.canvas.restore();
    }
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (child != null) visitor(child);
  }
}

class BlurryContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double height, width;
  final Color bgColor;

  const BlurryContainer({
    this.child,
    this.blur = 5,
    this.height,
    this.width,
    this.bgColor = Colors.transparent,
    //this.colorOpacity = kColorOpacity,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          height: height,
          width: width,
          color: bgColor,
          child: child ?? const SizedBox(),
        ),
      ),
    );
  }
}
