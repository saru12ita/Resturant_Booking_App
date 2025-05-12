import 'package:flutter/material.dart';
import 'package:resturant_reservation/Widgets/common_appbar_view.dart';
import 'package:resturant_reservation/Widgets/remove_focuse.dart';
import 'package:resturant_reservation/language/appLocalizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppBarView(
              iconData: Icons.arrow_back_ios_new,
              titleText: AppLocalizations(context).of("login"),
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(child: SingleChildScrollView(
               child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top:32),
                  child: FaceBookTwitterButtonView(),)
                ],
               ),
            ),),
          ],
        ),
      ),
    );
  }
}
