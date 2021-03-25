import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class DNeuInput extends StatefulWidget {
  final String hint;
  final String error;
  final Widget icon;
  final String hintTextField;
  final TextEditingController controller;
  final Color errorColor;
  final bool obscure;
  final bool tradeNum;
  final bool readOnly;
  final Function onChanged;

  const DNeuInput(
      {@required this.hint,
      this.error,
      this.errorColor = const Color(0xFFC02C2C),
      @required this.controller,
      Key key,
      this.obscure = false,
      this.tradeNum = false,
      this.readOnly = false,
      this.icon,
      this.onChanged,
      this.hintTextField})
      : super(key: key);

  @override
  _DNeuInputState createState() => _DNeuInputState();
}

class _DNeuInputState extends State<DNeuInput> {
  FocusNode _focus;

  String error;
  bool dead = false;

  @override
  void initState() {
    _focus = FocusNode();

    error = widget.error;
    _focus.addListener(() {
      if (!dead) {
        setState(() {});
      }
    });

    widget.controller.addListener(() {
      if (widget.controller.text.isNotEmpty && error != null && !dead) {
        setState(() {
          error = null;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _focus.dispose();
    dead = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    return Column(
      key: widget.key,
      children: [
        if (widget.hint != null)
          Text(
            widget.hint,
            style: GoogleFonts.rubik(fontSize: 18, letterSpacing: 0.4, color: const Color(0xFF85898F)),
          ),
        if (widget.hint != null) const SizedBox(height: 9),
        Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 33),
            child: AnimatedContainer(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              height: error != null ? 40 : 0,
              decoration: BoxDecoration(color: widget.errorColor, borderRadius: BorderRadius.circular(10)),
              duration: const Duration(milliseconds: 400),
              child: SizedBox(
                height: 23,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: error != null ? error.toUpperCase() : '',
                      style: GoogleFonts.rubik(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFF2F2F2),
                          letterSpacing: 0.8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 51,
            child: Stack(
              children: [
                GradientBorder(
                    width: _focus.hasFocus ? 1 : 0.5,
                    radius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: _focus.hasFocus
                            ? const [Color(0xFFFFB26C), Color(0xFFFFB26C)]
                            : const [Colors.transparent, Colors.transparent]),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: InnerShadow(
                        color: const Color(0xFF414567),
                        // offset: const Offset(-5, -5),
                        offset: const Offset(-1, -1),
                        blur: 15 / 3,
                        child: InnerShadow(
                          color: _focus.hasFocus ? const Color(0xFFFF871A).withOpacity(0.2) : const Color(0xFF151729),
                          // offset: const Offset(5, 5),
                          offset: const Offset(0, 4),
                          blur: 10 / 2,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: const [Color(0xFF252941), Color(0xFF252941)])),
                            // colors: const [Color(0xffEEF1F5), Color(0xffE6E9EF)])),
                          ),
                        ),
                      ),
                    )),
                Row(
                  children: [
                    if(widget.icon != null)
                    Container(child: widget.icon),
                    Expanded(
                      child: TextField(
                        readOnly: widget.readOnly,
                        onChanged: widget.onChanged ?? (_) {},
                        controller: widget.controller,
                        focusNode: _focus,
                        obscureText: widget.obscure,
                        keyboardType: widget.tradeNum ? TextInputType.number : TextInputType.text,
                        style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                        decoration: InputDecoration(
                            hintText: widget.hintTextField ?? '',
                            hintStyle: GoogleFonts.rubik(
                                color: !widget.tradeNum ? const Color(0xFF85898F) : const Color(0xFFF2F2F2),
                                fontSize: 15),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ]),
      ],
    );
  }
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
