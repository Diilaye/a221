import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';

class ArticleImageBlock extends StatefulWidget {
  final bool tag;
  final String tagS;

  final String img;

  final String desc;

  final double size;
  const ArticleImageBlock(
      {super.key,
      this.tag = true,
      required this.tagS,
      required this.img,
      required this.desc,
      this.size = 16});

  @override
  State<ArticleImageBlock> createState() => _ArticleImageBlockState();
}

class _ArticleImageBlockState extends State<ArticleImageBlock> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Stack(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (event) => setState(() {
                hover = true;
              }),
              onExit: (event) => setState(() {
                hover = false;
              }),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.img), fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        paddingHorizontalGlobal(),
                        Text(
                          "Afrique".toUpperCase(),
                          style: fontFammilyDii(context, 10, rouge,
                              FontWeight.bold, FontStyle.normal),
                        )
                      ],
                    ),
                    paddingVerticalGlobal(8),
                    Row(
                      children: [
                        paddingHorizontalGlobal(),
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 1,
                              color: blanc,
                            )),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  height: 1,
                                  color: blanc,
                                )),
                          ],
                        )),
                        paddingHorizontalGlobal(),
                      ],
                    ),
                    paddingVerticalGlobal(4),
                    Row(
                      children: [
                        paddingHorizontalGlobal(),
                        Text(
                          "Mardi 25 juin 2024 - 10:41",
                          style: fontFammilyDii(context, 8, blanc,
                              FontWeight.bold, FontStyle.normal),
                        )
                      ],
                    ),
                    paddingVerticalGlobal(8),
                    Row(
                      children: [
                        paddingHorizontalGlobal(),
                        Expanded(
                            child: Text(
                          widget.desc.toUpperCase(),
                          overflow: TextOverflow.clip,
                          style: hover
                              ? fontFammilyDii(context, widget.size, rouge,
                                  FontWeight.bold, FontStyle.normal)
                              : fontFammilyDii(context, widget.size, blanc,
                                  FontWeight.w600, FontStyle.normal),
                        )),
                        paddingHorizontalGlobal(),
                      ],
                    ),
                    paddingVerticalGlobal()
                  ],
                ),
              ),
            ),
            if (widget.tag)
              Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    height: 35,
                    width: 90,
                    color: rouge,
                    child: Center(
                      child: Text(
                        widget.tagS.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: blanc),
                      ),
                    ),
                  ))
          ],
        ));
  }
}
