import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItemSectionRubrique extends StatelessWidget {
  final String titre;
  final int sub;
  const MenuItemSectionRubrique({super.key, required this.titre, this.sub = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            paddingHorizontalGlobal(8),
            Text(
              titre.toUpperCase(),
              style: TextStyle(
                  fontSize: sub == 0 ? 15 : 13,
                  fontWeight: sub == 0 ? FontWeight.w600 : FontWeight.w400,
                  color: noir),
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.chevron_right,
              size: 12,
              color: noir,
            ),
            paddingHorizontalGlobal(8),
          ],
        ),
        paddingVerticalGlobal(8),
        Row(
          children: [
            paddingHorizontalGlobal(8),
            Expanded(
              child: Container(
                height: .5,
                color: noir,
              ),
            ),
            paddingHorizontalGlobal(8),
          ],
        )
      ],
    );
  }
}
