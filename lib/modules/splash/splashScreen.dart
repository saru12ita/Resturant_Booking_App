import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_reservation/Widgets/common_button.dart';
import 'package:resturant_reservation/language/appLocalizations.dart';
import 'package:resturant_reservation/providers/theme_provider.dart';
import 'package:resturant_reservation/routes/routes_names.dart';
import 'package:resturant_reservation/utils/localfiles.dart';
import 'package:resturant_reservation/utils/text_styles.dart';
import 'package:resturant_reservation/utils/themes.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool isLoadText = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _loadApplicationLocalization(),
    );
    super.initState();
  }

  Future<void> _loadApplicationLocalization() async {
    try {
      setState(() {
        isLoadText = true;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeProvider>(context);
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              foregroundDecoration:
                  !appTheme.isLightMode
                      ? BoxDecoration(
                        color: Theme.of(
                          context,
                        ).dialogBackgroundColor.withOpacity(0.4),
                      )
                      : null,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(Localfiles.introduction, fit: BoxFit.cover),
            ),
            Column(
              children: <Widget>[
                Expanded(flex: 1, child: SizedBox()),
                Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).dividerColor,
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(Localfiles.appIcon),
                    ),
                  ),
                ),
                SizedBox(height: 17),
                Text(
                  "Book Resturant",
                  textAlign: TextAlign.left,
                  style: TextStyles(
                    context,
                  ).getBoldStyle().copyWith(fontSize: 24),
                ),
                SizedBox(height: 17),
                AnimatedOpacity(
                  opacity: isLoadText ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 420),
                  child: Text(
                    AppLocalizations(context).of("best_resturant_deals"),
                    textAlign: TextAlign.left,
                    style: TextStyles(context).getRegularStyle().copyWith(),
                  ),
                ),
                Expanded(flex: 4, child: SizedBox()),
                AnimatedOpacity(
                  opacity: isLoadText ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 680),
                  child: CommonButton(
                    padding:const  EdgeInsets.only(
                      left: 48,
                      right: 48,
                      top: 8,
                      bottom: 8,
                    ),
                    buttonText: AppLocalizations(context).of("get_started"),
                    onTap: (){
                     NavigationServices(context).goToIntroductionScreen();
                    },
                  ),
                ),

                AnimatedOpacity(
                  opacity: isLoadText ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 680),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                      top: 16,
                    ),

                    child: Text(
                      AppLocalizations(context).of("already_have_account"),
                      textAlign: TextAlign.left,
                      style: TextStyles(context).getRegularStyle().copyWith(
                        color: AppTheme.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
