import 'package:flutter/material.dart';
import 'package:resturant_reservation/Widgets/common_appbar_view.dart';
import 'package:resturant_reservation/Widgets/common_button.dart';
import 'package:resturant_reservation/Widgets/common_textfield_view.dart';
import 'package:resturant_reservation/Widgets/remove_focuse.dart';
import 'package:resturant_reservation/language/appLocalizations.dart';
import 'package:resturant_reservation/modules/Login/facebook_twitter_button_view.dart';
import 'package:resturant_reservation/routes/routes_names.dart';
import 'package:resturant_reservation/utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _errorEmail = '';
  TextEditingController _emailController = TextEditingController();
  String _errorPassword = '';
  TextEditingController _passwordController = TextEditingController();
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 32,
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: FaceBookTwitterButtonView(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        AppLocalizations(context).of("log_with mail"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                    CommonTextFieldView(
                      controller: _emailController,
                      errorText: _errorEmail,
                      titleText: AppLocalizations(context).of("your_mail"),
                      padding: EdgeInsets.only(left: 24, right: 24),
                      hintText: AppLocalizations(
                        context,
                      ).of("enter_your_email"),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String txt) {},
                    ),

                    CommonTextFieldView(
                      controller: _passwordController,
                      errorText: _errorPassword,
                      titleText: AppLocalizations(context).of("password"),
                      padding: EdgeInsets.only(left: 24, right: 24),
                      hintText: AppLocalizations(context).of("enter_password"),
                      onChanged: (String txt) {},
                      keyboardType: TextInputType.text,
                      isObsecureText: true,
                    ),

                    _forgotYourPasswordUI(),
                    CommonButton(
                      padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
                      buttonText: AppLocalizations(context).of('login'),
                      onTap: () {
                        if (allValidation())
                          NavigationServices(context).gotoBottomTabScreen();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _forgotYourPasswordUI() {
    return Padding(
      padding: EdgeInsets.only(top: 8, right: 16, bottom: 8, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            onTap: () {
              NavigationServices(context).gotoForgotPasswordScreen();
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                AppLocalizations(context).of("forgot_your_Password"),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool allValidation() {
    bool isValid = true;
    if (_emailController.text.trim().isEmpty) {
      _errorEmail = AppLocalizations(context).of('email_cannot_empty');
      isValid = false;
    } else if (!Validator.validateEmail(_emailController.text.trim())) {
      _errorEmail = AppLocalizations(context).of('enter_valid_email');
      isValid = false;
    } else {
      _errorEmail = '';
    }

    if (_passwordController.text.trim().isEmpty) {
      _errorPassword = AppLocalizations(context).of('password_cannot_empty');
      isValid = false;
    } else if (_passwordController.text.trim().length < 8) {
      _errorPassword = AppLocalizations(context).of('valid_password');
      isValid = false;
    } else {
      _errorPassword = '';
    }
    setState(() {});
    return isValid;
  }
}
