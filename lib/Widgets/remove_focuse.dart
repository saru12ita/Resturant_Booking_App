import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RemoveFocuse extends StatelessWidget {
  final Widget child;
  final VoidCallback? onClick;
  const RemoveFocuse({super.key, required this.child, this.onClick});

  @override
  Widget build(BuildContext context) {
    return kIsWeb ?
    GestureDetector(
      onTap: onClick,
      child: child,
    ): InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onClick,
      child: child,
    );
  }
}