import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore_for_file: avoid_print
import 'package:faker_dart/faker_dart.dart';

class ArticleSectionSecondaireWithoutBG extends StatelessWidget {
  final Color color;
  const ArticleSectionSecondaireWithoutBG(
      {super.key, this.color = const Color.fromARGB(255, 255, 255, 255)});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(Faker.instance.image.image()),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          paddingHorizontalGlobal(6),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  paddingVerticalGlobal(),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.clock_solid,
                        color: color,
                        size: 12,
                      ),
                      Text(
                        '  il y a ${Faker.instance.datatype.number(max: 20)} jours ',
                        style: fontFammilyDii(context, 12, color,
                            FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(8),
                  Expanded(
                    child: Text(
                      Faker.instance.lorem.sentence(wordCount: 15),
                      overflow: TextOverflow.fade,
                      style: fontFammilyDii(context, 10, color, FontWeight.w300,
                          FontStyle.normal),
                    ),
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}
