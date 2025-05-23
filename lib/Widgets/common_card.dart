import 'package:flutter/material.dart';
import 'package:resturant_reservation/utils/themes.dart';

class CommonCard extends StatefulWidget {
  final Color? color;
  final double radius;
  final Widget? child;
  const CommonCard({super.key, this.color, required this.radius, this.child});

  @override
  State<CommonCard> createState() => _CommonCardState();
}

class _CommonCardState extends State<CommonCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:AppTheme.isLightMode ? 4:0,
      color:widget.color,
      shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(widget.radius) ,),
      child: widget.child,
      
    );
  }
}