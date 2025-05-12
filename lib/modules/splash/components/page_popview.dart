import 'package:flutter/material.dart';
import 'package:resturant_reservation/language/appLocalizations.dart';
import 'package:resturant_reservation/utils/text_styles.dart';

class PagePopUp extends StatelessWidget {
  final PageViewData imageData;
  const PagePopUp({super.key, required this.imageData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 120,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(imageData.assetImage, fit: BoxFit.cover),
              ),
            ),
          ),
        ),

        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              AppLocalizations(context).of(imageData.titleText),
              textAlign: TextAlign.center,
              style: TextStyles(context).getDescriptionStyle().copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
      ],
    );
  }
}

class PageViewData {
  final String titleText;
  final String subText;
  final String assetImage;

  PageViewData({
    required this.titleText,
    required this.subText,
    required this.assetImage,
  });
}
