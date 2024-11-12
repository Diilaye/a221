import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RubriqueTitle extends StatelessWidget {
  final String title;
  final bool noArrow;
  final bool isStyle;
  final Color color;
  final double heigth;
  const RubriqueTitle(
      {super.key,
      required this.title,
      this.color = const Color(0xffB30014),
      this.noArrow = false,
      this.isStyle = false,
      this.heigth = 60});

  @override
  Widget build(BuildContext context) {
    return isStyle
        ? Container(
            color: isStyle ? color : blanc,
            height: heigth,
            child: Column(
              children: [
                heigth != 25
                    ? paddingVerticalGlobal()
                    : paddingVerticalGlobal(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(title.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: blanc)),
                    paddingHorizontalGlobal(8),
                  ],
                ),
                heigth != 25
                    ? paddingVerticalGlobal()
                    : paddingVerticalGlobal(4),
              ],
            ),
          )
        : Column(
            children: [
              paddingVerticalGlobal(),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(title.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: noir)),
                  ),
                  if (noArrow == false)
                    Icon(
                      CupertinoIcons.arrow_right,
                      size: 14,
                      color: noir,
                    ),
                ],
              ),
              paddingVerticalGlobal(),
            ],
          );
  }
}
