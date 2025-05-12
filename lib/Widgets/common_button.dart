import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final String? buttonText;
  final Widget? buttonTextWidget;
  final Color? textColor,backgroundColor;
  final bool? isClickable;
  final double radius;



   CommonButton({
  super.key,
  this.onTap,
  this.padding,
  this.buttonText,
  this.buttonTextWidget,
  this.textColor,
  this.backgroundColor,
  this.isClickable,
  this.radius = 24,
});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(),
      child:Tapeffect() ,
    );
  }
}