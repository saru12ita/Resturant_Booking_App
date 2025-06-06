import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:resturant_reservation/Widgets/common_card.dart';
import 'package:resturant_reservation/language/appLocalizations.dart';
import 'package:resturant_reservation/modules/bottomTab/components/tabButtonUI.dart';
import 'package:resturant_reservation/modules/explore/homeExploreScreen.dart';
import 'package:resturant_reservation/modules/mybookings/mybookingScreen.dart';
import 'package:resturant_reservation/modules/profile/profileScreen.dart';
import 'package:resturant_reservation/providers/theme_provider.dart';
import 'package:resturant_reservation/utils/themes.dart';

class BottomTabScreen extends StatefulWidget {
  const BottomTabScreen({super.key});

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  BottomBarType bottomBarType = BottomBarType.Explore;
  bool _isFirstTime = true;
  Widget _indexView = Container();
  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    _indexView = Container();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _startLoadingScreen();
    });
    super.initState();
  }

  Future _startLoadingScreen() async {
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      _isFirstTime = false;
      _indexView = HomeExploreScreen(animationController: _animationController);
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder:
          (_, provider, child) => Container(
            child: Scaffold(
              bottomNavigationBar: Container(
                height: 60 + MediaQuery.of(context).padding.bottom,
                child: getBottomBarUI(bottomBarType),
              ),
              body:
                  _isFirstTime
                      ? Center(
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      )
                      : _indexView,
            ),
          ),
    );
  }

  getBottomBarUI(BottomBarType bottomBarType) {
    return CommonCard(
      color: AppTheme.backgroundColor,
      radius: 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TabButtonUI(
                icon: Icons.search,
                isSelected: bottomBarType == BottomBarType.Explore,
                text: AppLocalizations(context).of("explore"),
                onTap: () {
                  tapClick(BottomBarType.Explore);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.calendar,
                isSelected: bottomBarType == BottomBarType.Reservations,
                text: AppLocalizations(context).of("Reserve"),
                onTap: () {
                  tapClick(BottomBarType.Reservations);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.user,
                isSelected: bottomBarType == BottomBarType.profile,
                text: AppLocalizations(context).of("profile"),
                onTap: () {
                  tapClick(BottomBarType.profile);
                },
              ),
            ],
          ),

          SizedBox(height: 60 + MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  void tapClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      _animationController.reverse().then(
        (value) => {
          if (tabType == BottomBarType.Explore)
            {
              setState(() {
                _indexView =HomeExploreScreen(animationController: _animationController);
              }),
            }
          else if (tabType == BottomBarType.Reservations)
            {
              setState(() {
                _indexView =Mybookingscreen(animationController: _animationController);
              }),
            }
          else if (tabType == BottomBarType.profile)
            {
              setState(() {
                _indexView =profileScreen(animationController: _animationController);
              }),
            },
        },
      );
    }
  }
}

enum BottomBarType { Explore, Reservations, profile }
