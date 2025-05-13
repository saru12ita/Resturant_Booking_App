
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:resturant_reservation/BusinessDashBoard/BusinessDashboard/Businessdashboard.dart';
import 'package:resturant_reservation/Widgets/common_card.dart';
import 'package:resturant_reservation/language/appLocalizations.dart';
import 'package:resturant_reservation/modules/bottomTab/components/tabButtonUI.dart';
import 'package:resturant_reservation/modules/explore/homeExploreScreen.dart';
import 'package:resturant_reservation/modules/mybookings/mybookingScreen.dart';
import 'package:resturant_reservation/modules/profile/profileScreen.dart';
import 'package:resturant_reservation/providers/theme_provider.dart';
import 'package:resturant_reservation/utils/themes.dart';

class ProductDetailsReportScreen extends StatefulWidget {
  const ProductDetailsReportScreen({super.key});

  @override
  State<ProductDetailsReportScreen> createState() => _ProductDetailsReportScreenState();
}

class _ProductDetailsReportScreenState extends State<ProductDetailsReportScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  BottomBarType bottomBarType = BottomBarType.dashboard;
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
      _indexView = DashboardScreen(animationController: _animationController);
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
                icon: Icons.dashboard,
                isSelected: bottomBarType == BottomBarType.dashboard,
                text: AppLocalizations(context).of("dashboard"),
                onTap: () {
                  tapClick(BottomBarType.dashboard);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.calendar,
                isSelected: bottomBarType == BottomBarType.reservations,
                text: AppLocalizations(context).of("reservations"),
                onTap: () {
                  tapClick(BottomBarType.reservations);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.chartSimple,
                isSelected: bottomBarType == BottomBarType.analytics,
                text: AppLocalizations(context).of("analytics"),
                onTap: () {
                  tapClick(BottomBarType.analytics);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.gear,
                isSelected: bottomBarType == BottomBarType.settings,
                text: AppLocalizations(context).of("settings"),
                onTap: () {
                  tapClick(BottomBarType.settings);
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
          if (tabType == BottomBarType.dashboard)
            {
              setState(() {
                _indexView =DashboardScreen(animationController: _animationController);
              }),
            }
          else if (tabType == BottomBarType.reservations)
            {
              setState(() {
                _indexView =Mybookingscreen(animationController: _animationController);
              }),
            }
          else if (tabType == BottomBarType.analytics)
            {
              setState(() {
                _indexView =profileScreen(animationController: _animationController);
              }),
            }
            else if (tabType == BottomBarType.settings)
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

enum BottomBarType { dashboard,reservations,analytics,settings }
