import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleSectionSecondaire extends StatefulWidget {
  final bool noShadow;
  const ArticleSectionSecondaire({super.key, this.noShadow = false});

  @override
  State<ArticleSectionSecondaire> createState() =>
      _ArticleSectionSecondaireState();
}

class _ArticleSectionSecondaireState extends State<ArticleSectionSecondaire> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MouseRegion(
      onEnter: (event) => setState(() {
        isActive = true;
      }),
      onExit: (event) => setState(() {
        isActive = false;
      }),
      child: Container(
        decoration: BoxDecoration(
            color: blanc,
            boxShadow: widget.noShadow
                ? []
                : [BoxShadow(blurRadius: 5, color: noir.withOpacity(.3))]),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/imagea3.jpeg"),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      paddingVerticalGlobal(),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.clock_solid,
                            color: noir,
                            size: 12,
                          ),
                          Text('  il y a 2 jours',
                              style: fontFammilyDii(context, 10, noir,
                                  FontWeight.bold, FontStyle.normal)),
                        ],
                      ),
                      paddingVerticalGlobal(8),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "C'EST CE QUE SONKO DEVRAIT FAIRE D'ABORD AVANT DE DEMANDER AUX ENTREPRISES DE PRESSE DE..., BABACAR BITEYE",
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.clip,
                                style: isActive
                                    ? fontFammilyDii(context, 8, rouge,
                                        FontWeight.bold, FontStyle.normal)
                                    : fontFammilyDii(context, 8, noir,
                                        FontWeight.w600, FontStyle.normal),
                              ),
                            ),
                            paddingHorizontalGlobal(4)
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
