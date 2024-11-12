import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';

class ImageScreenUi extends StatelessWidget {
  const ImageScreenUi({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: .0,
        elevation: .0,
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: blanc,
          ),
          Positioned(
              child: Container(
            height: 80,
            width: size.width,
            color: blanc,
            child: Column(
              children: [
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Text(
                      'RECHERCHER média'.toUpperCase(),
                      style: fontFammilyDii(context, 14, noir.withOpacity(.5),
                          FontWeight.w300, FontStyle.normal),
                    )
                  ],
                ),
                paddingVerticalGlobal(),
                Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                      child: TextField(
                        // controller: emissionBloc.url,
                        decoration: InputDecoration(
                          hintText: "RECHERCHER média".toUpperCase(),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
