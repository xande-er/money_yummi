import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class DFilledButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool blur;

  const DFilledButton(this.text, this.onPressed, this.blur);

  @override
  Widget build(BuildContext c) {
    return Container(
      height: 55,
      child: NeumorphicButton(
        style: NeumorphicStyle(
            border: NeumorphicBorder(isEnabled: true, width: 2, color: Color(0xFFFF871A)),
            intensity: 0.8,
            shadowLightColorEmboss: const Color(0xFFFF871A),
            shadowLightColor: const Color(0xFFFF871A),
            shadowDarkColor: const Color(0xFFFF871A),
            shadowDarkColorEmboss: const Color(0xFFFF871A),
            color: blur ? Color(0xFFFF871A) : Colors.transparent,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40))),
        onPressed: onPressed,
        child: Center(
            child: onPressed != null
                ? Text(
                    text.toUpperCase(),
                    style: GoogleFonts.rubik(color: const Color(0xFFF2F2F2), fontSize: 17, fontWeight: FontWeight.bold),
                  )
                : const SizedBox(
                    height: 32,
                    width: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF2F2F2)),
                    ),
                  )),
      ),
    );
  }
}

class DTransparentScalableButton extends StatefulWidget {
  final Widget child;
  final Function() onPressed;
  final ScaleFormat scale;

  const DTransparentScalableButton({@required this.child, @required this.onPressed, @required this.scale});

  @override
  _DTransparentScalableButtonState createState() => _DTransparentScalableButtonState();
}

class _DTransparentScalableButtonState extends State<DTransparentScalableButton> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  AnimationStatusListener listener;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 50), vsync: this);
    animation = Tween<double>(begin: 1, end: widget.scale == ScaleFormat.big ? 0.86 : 0.94).animate(controller)
      ..addListener(() => setState(() {}));

    listener = (status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
        controller.removeStatusListener(listener);
      }
    };

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) => controller.forward(),
        onTapUp: (_) {
          widget.onPressed();

          if (controller.isAnimating) {
            controller.addStatusListener(listener);
          } else {
            controller.reverse();
          }
        },
        onTapCancel: () => controller.reverse(),
        child: Transform.scale(
          scale: animation.value,
          child: widget.child,
        ),
      );
}

enum ScaleFormat { small, big }
