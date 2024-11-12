// import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:faker_dart/faker_dart.dart';

class ArticleSectionTopSecondaireRowWidget extends StatelessWidget {
  final String tag;
  final Color colorT;
  final Color color;
  const ArticleSectionTopSecondaireRowWidget({
    super.key,
    this.colorT = const Color(0xff00A950),
    this.color = const Color(0xff00A950),
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          paddingHorizontalGlobal(8),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(Faker.instance.image.image()),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        color: colorT,
                        child: Row(
                          children: [
                            paddingHorizontalGlobal(8),
                            Text(
                              tag.toUpperCase(),
                              style: fontFammilyDii(context, 12, color,
                                  FontWeight.bold, FontStyle.normal),
                            ),
                            paddingHorizontalGlobal(8),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          paddingHorizontalGlobal(8),
          Expanded(
            child: Column(
              children: [
                paddingVerticalGlobal(4),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.clock_solid,
                      color: color,
                      size: 12,
                    ),
                    Text(
                      ' il y a ${Faker.instance.datatype.number(max: 10)} jours',
                      style: fontFammilyDii(context, 12, color, FontWeight.bold,
                          FontStyle.normal),
                    ),
                  ],
                ),
                paddingVerticalGlobal(4),
                Text(
                  Faker.instance.lorem.text(paragraphCount: 1),
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 12, color: color, fontWeight: FontWeight.bold),
                ),
                paddingVerticalGlobal(4),
                Expanded(
                  child: Text(
                    Faker.instance.lorem.text(paragraphCount: 5),
                    overflow: TextOverflow.fade,
                    style: fontFammilyDii(
                        context, 10, color, FontWeight.w300, FontStyle.normal),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 25,
                      color: colorT,
                      child: Row(
                        children: [
                          paddingHorizontalGlobal(8),
                          Text(
                            'lire la suite'.toUpperCase(),
                            style: fontFammilyDii(context, 12, color,
                                FontWeight.w100, FontStyle.normal),
                          ),
                          paddingHorizontalGlobal(8),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          paddingHorizontalGlobal(8),
        ],
      ),
    );
  }
}
