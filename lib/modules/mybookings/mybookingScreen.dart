import 'package:flutter/material.dart';

class Mybookingscreen extends StatefulWidget {
  final AnimationController animationController;
  const Mybookingscreen({super.key, required this.animationController});

  @override
  State<Mybookingscreen> createState() => _MybookingscreenState();
}

class _MybookingscreenState extends State<Mybookingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: Text("My Favorite Trips"),
      ),
    );
  }
}