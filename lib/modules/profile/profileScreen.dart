import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  final AnimationController animationController;
  const profileScreen({super.key, required this.animationController});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}