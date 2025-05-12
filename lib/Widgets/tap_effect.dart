/*


import 'package:flutter/material.dart';

class TapEffect extends StatefulWidget {
  final bool isClickable;
  final VoidCallback? onClick;
  final Widget child;

  TapEffect({
    Key? key,
    this.isClickable = true,
    this.onClick,
    required this.child,
  }) : super(key: key);

  @override
  _TapEffectState createState() => _TapEffectState();
}

class _TapEffectState extends State<TapEffect>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  DateTime taptime = DateTime.now();
  bool isProgress = false;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    animationController!.animateTo(
      1.0,
      duration: Duration(milliseconds: 0),
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  Future<void> onTapCancel() async {
    if (widget.isClickable) {
      await _onDelayed();
      animationController!.animateTo(
        1.0,
        duration: Duration(milliseconds: 240),
        curve: Curves.fastOutSlowIn,
      );
    }
    isProgress = false;
  }

  Future<void> _onDelayed() async {
    if (widget.isClickable) {
      final int tapDuration =
          DateTime.now().millisecondsSinceEpoch -
          taptime.millisecondsSinceEpoch;
      if (tapDuration < 120) {
        await Future<dynamic>.delayed(Duration(milliseconds: 200));
      }
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.isClickable) {
          await Future<dynamic>.delayed(Duration(milliseconds: 200));
          try {
            if (!isProgress) {
              widget.onClick!();
              isProgress = true;
            }
          } catch (_) {}
        }
      },
      onTapDown: (TapDownDetails details) {
        if (widget.isClickable) {
          taptime = DateTime.now();
          animationController!.animateTo(
            1.0,
            duration: Duration(milliseconds: 240),
            curve: Curves.fastOutSlowIn,
          );
        }
        isProgress = true;
      },
      onTapUp: (TapUpDetails details) {
        onTapCancel();
      },
      onTapCancel: () {
        onTapCancel();
      },
      child: AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale:animationController!.value,
            origin: Offset(0.0, 0.0),
            child: widget.child,
          );
        },
      ),
    );
  }
}

*/


import 'package:flutter/material.dart';

/// A widget that applies a scaling "tap" animation effect to its child.
/// Ideal for buttons and clickable elements to provide a smooth user interaction.
class TapEffect extends StatefulWidget {
  final bool isClickable;
  final VoidCallback? onClick;
  final Widget child;

  const TapEffect({
    Key? key,
    this.isClickable = true,
    this.onClick,
    required this.child,
  }) : super(key: key);

  @override
  _TapEffectState createState() => _TapEffectState();
}

class _TapEffectState extends State<TapEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1.0,
    )..value = 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (!widget.isClickable || widget.onClick == null) return;

    try {
      await _animationController.reverse();
      await _animationController.forward();
      widget.onClick!();
    } catch (e) {
      debugPrint("TapEffect Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.translucent,
      child: ScaleTransition(
        scale: _animationController,
        child: widget.child,
      ),
    );
  }
}
