import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:resturant_reservation/common/common.dart';
import 'package:resturant_reservation/language/appLocalizations.dart';
import 'package:resturant_reservation/modules/splash/introductionscreen.dart';
import 'package:resturant_reservation/modules/splash/splashScreen.dart';
import 'package:resturant_reservation/providers/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:resturant_reservation/routes/routes.dart';
import 'package:resturant_reservation/utils/enum.dart';
BuildContext? applicationcontext;

class MotelApp extends StatefulWidget {
  @override
  _MotelAppState createState() => _MotelAppState();
}

class _MotelAppState extends State<MotelApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, provider, child) {
        applicationcontext = context;
        final ThemeData _theme = provider.themeData;
        return MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale('fr'),
            const Locale('Ja'),
            const Locale('Np'),
          ],
          navigatorKey: navigatorKey,
          title: 'Motel',
          debugShowCheckedModeBanner: false,
          theme: _theme,
          routes: _buildRoutes(),
          builder: (BuildContext context, Widget? child) {

            _setFirstTimeSomeData(context, _theme);
              
              return Directionality(
  textDirection: context.read<ThemeProvider>().languageType == LanguageType.ar
      ? TextDirection.rtl
      : TextDirection.ltr,
  child: Builder(
    builder: (BuildContext context){
      return  MediaQuery(
        data:MediaQuery.of(context).copyWith(
          textScaleFactor: MediaQuery.of(context).size.width > 360 ? 1.0:(MediaQuery.of(context).size.width >= 340 ? 0.9 : 0.8),
        ) , child: child?? SizedBox()
        );
    }),
);


            
          
          },
        );
      },
    );
  }

  void _setFirstTimeSomeData(BuildContext context, ThemeData theme) {
    applicationcontext = context;
    _setStatusBarNavigationBarTheme(theme);
    context.read<ThemeProvider>().checkAndSetThemeMode(
              MediaQuery.of(context).platformBrightness,
            );
      context.read<ThemeProvider>().checkAndSetLanguage();
            context.read<ThemeProvider>().checkAndSetFonType();
            context.read<ThemeProvider>().checkAndSetColorType();
  }

  Map<String, WidgetBuilder> _buildRoutes() {
 return{
  RoutesName.Splash:(BuildContext context) => Splashscreen(),
  RoutesName.IntroductionScreen:(BuildContext context) => IntroductionScreen(),
 };
  }


void _setStatusBarNavigationBarTheme(ThemeData theme) {
  final brightness = !kIsWeb && Platform.isAndroid
      ? (theme.brightness == Brightness.light ? Brightness.dark : Brightness.light)
      : theme.brightness;

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: brightness,
    statusBarIconBrightness: brightness,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: brightness,
  ));
}
  }


