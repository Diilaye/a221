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
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.grey[50]!],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image à gauche
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        BASE_URL_ASSET + article.imageArticle!.url!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                color: rouge,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  // Contenu à droite
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: rouge.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            article.tags!.titre!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: rouge,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          article.titre!,
                          style: fontFammilyDii(context, 18, noir,
                              FontWeight.bold, FontStyle.normal),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        paddingVerticalGlobal(12),
                        HtmlWidget(
                          extractFirstTwoSentences(article.description!, 1),
                          textStyle: fontFammilyDii(context, 13, Colors.grey[700],
                              FontWeight.w400, FontStyle.normal),
                        ),
                        paddingVerticalGlobal(12),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                            SizedBox(width: 6),
                            Text(
                              showDate(article.date!),
                              style: fontFammilyDii(context, 12, Colors.grey[600],
                                  FontWeight.w400, FontStyle.normal),
                            ),
                            SizedBox(width: 16),
                            Icon(Icons.person, size: 14, color: Colors.grey[500]),
                            SizedBox(width: 6),
                            Text(
                              '${article.author!.prenom!} ${article.author!.nom!}',
                              style: fontFammilyDii(context, 12, Colors.grey[600],
                                  FontWeight.w400, FontStyle.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
