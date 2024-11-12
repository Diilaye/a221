import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';

class TitreTopFooter extends StatelessWidget {
  final String titre;
  final bool haveLastBlock;
  const TitreTopFooter(
      {super.key, required this.titre, this.haveLastBlock = true});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: deviceName(size) == ScreenType.Mobile
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Text(
          titre,
          style: fontFammilyDii(
              context,
              deviceName(size) == ScreenType.Mobile ? 14 : 14,
              blanc,
              FontWeight.bold,
              FontStyle.normal),
        ),
        deviceName(size) == ScreenType.Mobile
            ? paddingHorizontalGlobal(0)
            : paddingHorizontalGlobal(),
        if (haveLastBlock)
          Container(
            width: 1,
            height: 10,
            color: blanc.withOpacity(.5),
          ),
        deviceName(size) == ScreenType.Mobile
            ? paddingHorizontalGlobal(0)
            : paddingHorizontalGlobal(32),
      ],
    );
  }
}
