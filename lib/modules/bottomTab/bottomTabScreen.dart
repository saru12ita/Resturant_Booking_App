import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_reservation/modules/explore/homeExploreScreen.dart';
import 'package:resturant_reservation/providers/theme_provider.dart';

class BottomTabScreen extends StatefulWidget {
  const BottomTabScreen({super.key});

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  Widget _indexView = Container();
  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    _indexView = Container();
    WidgetsBinding.instance!.addPostFrameCallback((_) {});
    super.initState();
  }

  Future _startLoadingScreen() async {
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      _indexView = HomeExploreScreen(
        animationController: _animationController,
        );
        _animationController.forward();
    });
  }
  
  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(

      builder: (_,provider,child)=>Scaffold(
        bottomNavigationBar: Container(
          height:60+MediaQuery.of(context).padding.bottom,
          child: getBottomBarUI(bottomBarType),

        ),
      
      ),
    );
  }
  
  getBottomBarUI(Type bottomBarType) {
    
  }
}
enum bottomBarType{Explore,Reservations,profile}