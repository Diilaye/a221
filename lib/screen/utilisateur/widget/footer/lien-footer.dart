import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';

class LienFooterWidget extends StatefulWidget {
  final String titre;
  const LienFooterWidget({super.key, required this.titre});

  @override
  State<LienFooterWidget> createState() => _LienFooterWidgetState();
}

class _LienFooterWidgetState extends State<LienFooterWidget> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MouseRegion(
      onEnter: (event) => setState(() {
        isHover = true;
      }),
      onExit: (event) => setState(() {
        isHover = false;
      }),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.titre,
                style: fontFammilyDii(
                    context,
                    size.width >= 1440
                        ? 12
                        : size.width >= 1024 && size.width < 1440
                            ? 8
                            : 6,
                    blanc,
                    FontWeight.w500,
                    FontStyle.normal),
              ),
            ],
          ),
          paddingVerticalGlobal(4),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: isHover ? 1 : 0,
                  // width: 50,
                  color: blanc,
                ),
              ),
              const Expanded(flex: 2, child: SizedBox()),
            ],
          ),
          paddingVerticalGlobal(),
        ],
      ),
    );
  }
}
