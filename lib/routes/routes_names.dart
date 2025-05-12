
import 'package:flutter/material.dart';
import 'package:resturant_reservation/modules/Login/login_Screen.dart';
import 'package:resturant_reservation/routes/routes.dart';

class NavigationServices {
  final BuildContext context;

  NavigationServices(this.context);

  Future<dynamic> _pushMaterialPageRoute(
    Widget widget, {
    bool fullscreenDialog = false,
  }) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }
  void goToSplashScreen() {
  Navigator.pushNamedAndRemoveUntil(
    context,
    RoutesName.Splash,
    (Route<dynamic> route) => false,
  );
}

void goToIntroductionScreen() {
  Navigator.pushNamedAndRemoveUntil(
    context,
    RoutesName.IntroductionScreen,
    (Route<dynamic> route) => false,
  );
}

Future<dynamic> gotoLoginScreen() async{
  return await _pushMaterialPageRoute(LoginScreen());
}


}
