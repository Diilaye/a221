import 'package:actu/models/utilisateur/categorie-menu-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/date-showing-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/htm-to-string-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/utilisateur/home-bloc.dart';

import 'dart:js' as js;

class ArticleCategorieRowWidget extends StatelessWidget {
  final Articles article;

  const ArticleCategorieRowWidget({super.key, required this.article});
  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          homeUtilisateurBloc.setAticle(homeUtilisateurBloc.articles
              .lastWhere((e) => e.id! == article.id!));
          js.context.callMethod(
              'open', ['https://a221.net/article/${article.slug!}', '_self']);
        },
        child: Card(
          margin: EdgeInsets.only(top: 16.0),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0), // Espace réservé pour l'image
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.tags!.titre!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: Icon(Icons.article,
                                    size: 20.0, color: rouge),
                              ),
                            ),
                            TextSpan(
                              text: article.titre!,
                              style: fontFammilyDii(context, 16, noir,
                                  FontWeight.bold, FontStyle.normal),
                            ),
                            WidgetSpan(
                                child: SizedBox(
                              width: 120,
                              height: 2,
                            )),
                          ],
                        ),
                      ),
                      paddingVerticalGlobal(8),
                      HtmlWidget(
                        extractFirstTwoSentences(article.description!, 1),
                        textStyle: fontFammilyDii(context, 10, noir,
                            FontWeight.w300, FontStyle.normal),
                      ),
                      paddingVerticalGlobal(8),
                      Text(
                        'Publié le ${showDate(article.date!)}',
                        style: fontFammilyDii(context, 12, Colors.grey[600],
                            FontWeight.w300, FontStyle.normal),
                      ),
                      paddingVerticalGlobal(8),
                      Text(
                        '${article.author!.prenom!} ${article.author!.nom!}',
                        style: fontFammilyDii(context, 12, Colors.grey[600],
                            FontWeight.w300, FontStyle.normal),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          8.0), // Pour arrondir les coins de l'image
                      child: Image.network(
                        BASE_URL_ASSET +
                            article.imageArticle!
                                .url!, // Assurez-vous d'avoir l'image dans votre dossier assets
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
