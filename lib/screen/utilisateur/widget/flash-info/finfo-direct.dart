import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:faker_dart/faker_dart.dart';

class FinfoDirect extends StatelessWidget {
  final String heure, typeFlash;
  const FinfoDirect({super.key, required this.heure, required this.typeFlash});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MouseRegion(
      onEnter: (event) => null,
      onExit: (event) => null,
      cursor: SystemMouseCursors.click,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          paddingVerticalGlobal(),
          Row(
            children: [
              Text(
                heure,
                style: TextStyle(
                    fontSize: 12,
                    color: blanc.withOpacity(.7),
                    fontWeight: FontWeight.bold),
              ),
              paddingHorizontalGlobal(5),
              if (typeFlash != "")
                Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: rouge),
                ),
              paddingHorizontalGlobal(5),
              Text(
                typeFlash.toUpperCase(),
                style: TextStyle(
                    fontSize: 12, color: rouge, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          paddingVerticalGlobal(8),
          Expanded(
              child: Text(
            Faker.instance.lorem.sentence(wordCount: 5),
            textAlign: TextAlign.start,
            style: TextStyle(
                color: blanc, fontSize: 12, fontWeight: FontWeight.bold),
          )),
          paddingVerticalGlobal(),
        ],
      ),
    ));
  }
}
