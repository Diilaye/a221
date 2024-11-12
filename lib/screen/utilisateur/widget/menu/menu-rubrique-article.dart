import 'package:actu/models/utilisateur/categorie-menu-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';

class MenuArticleRubrique extends StatelessWidget {
  final Articles article;
  const MenuArticleRubrique({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 4,
        child: Card(
          elevation: .4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Image.network(
                    BASE_URL_ASSET + article.imageArticle!.url!,
                    fit: BoxFit.cover,
                  )),
              Expanded(
                child: Column(
                  children: [
                    paddingVerticalGlobal(4),
                    Row(
                      children: [
                        paddingHorizontalGlobal(4),
                        Expanded(
                          child: Text(article.tags!.titre!,
                              style: fontFammilyDii(context, 16, noir,
                                  FontWeight.bold, FontStyle.normal)),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                    paddingVerticalGlobal(4),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(article.titre!,
                            overflow: TextOverflow.fade,
                            style: fontFammilyDii(context, 12, noir,
                                FontWeight.w300, FontStyle.normal)),
                      ),
                    ),
                  ],
                ),
              ),
              paddingVerticalGlobal(4),
            ],
          ),
        ));
  }
}
