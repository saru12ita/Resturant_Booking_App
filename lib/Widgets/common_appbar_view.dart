import 'package:flutter/material.dart';
import 'package:resturant_reservation/utils/text_styles.dart';
import 'package:resturant_reservation/utils/themes.dart';

class CommonAppBarView extends StatelessWidget {
  final double? toPadding;
  final Widget? backWidget;
  final String titleText;
  final VoidCallback onBackClick;
  final IconData? iconData;
  const CommonAppBarView({
    super.key,
    this.toPadding,
    this.backWidget,
    required this.titleText,
    required this.onBackClick,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final paddingTop = toPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppBar().preferredSize.height,
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Container(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                    onTap: onBackClick,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child:
                          backWidget ??
                          Icon(iconData, color: AppTheme.primaryTextColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 4,left:24,right:24),
          child:Text(titleText,style:TextStyles(context).getTitleStyle(),),),
        ],
      ),
    );
  }
}
